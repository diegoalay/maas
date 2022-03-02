class Service < ApplicationRecord
  belongs_to :user_creator, class_name: "User", foreign_key: "user_creator_id"
  has_many :shifts

  def available_shifts
    week_init = WorkingWeek.where(service: self).order(:id).first&.week_id
    current_week = Time.current.strftime("%U").to_i

    if (week_init === nil) # there is no data for this service
      week_init = current_week
    elsif ((current_week - 5) > week_init) # create the following 5 days starting in the current week
      week_init = current_week
    end

    return (week_init..(5+week_init)).map {
    |n|
      {
        shift_id: WorkingWeek.create_shift(self, n).id, # search or create shift
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