class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    [first_name, last_name].join(" ")
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
    return false if (user != current_user)

    return true
  end
end
