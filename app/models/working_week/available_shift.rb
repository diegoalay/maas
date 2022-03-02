class WorkingWeek::AvailableShift < ApplicationRecord
  belongs_to :working_week
  belongs_to :user

  after_create :set_confirmed_shifts
  after_update :set_confirmed_shifts


  def set_confirmed_shifts
    working_week.service.schedule.where(status: false).each do |day|
      working_week.confirmed_shifts.where(day_id: day).delete_all # remove confirmations for disable days
    end

    # re calculate confirmed shifts
    available_shifts = working_week.available_shifts.where(status: true)
    week_id = working_week.week_id
    if (available_shifts.where.not(user: user).blank?) # there is any other user
      working_week.confirmed_shifts.find_or_create_by(
        user_id,
        week_id
      )
    else
      # try to assign hours equitative

    end
  end

  def available_fully_by_week?(week_id)

  end
end
