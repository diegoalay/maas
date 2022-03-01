class Service < ApplicationRecord
  belongs_to :user_creator, class_name: "User", foreign_key: "user_creator_id"
  has_many :shifts

  def available_shifts
    week_init = Shift.where(service: self).order(:id).first&.week_id
    current_week = Time.current.strftime("%U").to_i

    if ((current_week - 5) > week_init)
      week_init = current_week - 5
    end

    return (week_init..(5+week_init)).map {
    |n|
      {
        shift_id: Shift.create_shift(self, n).id, # search or create shift
        text: "Semana #{n}",
        value: n
      }
    }
  end

  def self.index
    services = Service.select("
      services.id,
      services.created_at,
      services.name,
      trim(
        concat(
          users.first_name,
          ' ',
          users.last_name
        )
      ) as user_creator_name
    ")
    .joins(:user_creator)
  end
end