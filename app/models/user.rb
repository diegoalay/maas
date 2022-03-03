class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_creator, class_name: 'User', foreign_key: 'user_creator_id', optional: true

  has_many :available_shifts, class_name: "WorkingWeek::AvailableShift"

  before_destroy :can_be_destroyed

  enum role: {
    admin: 0,
    employee: 1
  }

  def self.index(current_user, query)
    search = query[:filters][:search]&.downcase.to_s

    users = User.select(
      'users.id',
      'users.created_at',
      "trim(concat(users.first_name, ' ', users.last_name)) as user_name",
      "trim(concat(user_creators_users.first_name, ' ', user_creators_users.last_name)) as user_creator_name"
    ).left_joins(:user_creator)
    users = users.where("
      lower(users.first_name) like '%#{search}%' or
      lower(users.last_name) like '%#{search}%' or
      concat(lower(users.first_name), ' ', lower(users.last_name)) like '%#{search}%'
    ") unless search.blank?
    users = users.where.not(id: current_user.id) # remove logged user
    users = users.page(query[:pagination][:current_page]).per(query[:pagination][:per_page])
    .order("#{query[:pagination][:order_by]} #{query[:pagination][:order]} nulls last")

    { current_page: users.current_page, total_pages: users.total_pages, total_count: users.total_count, total_lenght: users.length, users: users }
  end

  def admin?
    role == 'admin'
  end

  def can_edit?(current_user)
    return true if current_user.id == id
    return true if current_user.admin?

    false
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def profile
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end

  def can_update?(user)
    return false if user != current_user

    true
  end

  private

  def can_be_destroyed
    errors.add(:base, "Existen turnos disponibles asignados a este usuario") and throw(:abort) unless WorkingWeek::ConfirmedShift.where(user_id: id).blank?
    errors.add(:base, "Existen turnos asignados a este usuario") and throw(:abort) unless WorkingWeek::ConfirmedShift.where(user_id: id).blank?
  end
end
