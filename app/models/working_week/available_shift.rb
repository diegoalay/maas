
class WorkingWeek::AvailableShift < ApplicationRecord
  belongs_to :working_week
  belongs_to :user

  after_create do |available_week|
    available_week.set_confirmed_shifts('create')
  end

  after_update do |available_week|
    available_week.set_confirmed_shifts('update')
  end

  def set_confirmed_shifts(type)
    service = working_week.service

    service.schedule.each do |day|
      unless day['status']
        working_week.confirmed_shifts.where(day_id: day).delete_all #  remove confirmations for disable days
      end
    end

    # re calculate confirmed shifts
    available_shifts = working_week.available_shifts.where(status: true)
    confirmed_shifts = working_week.confirmed_shifts

    if type == 'create' || (type == 'update' && status?) #  if the shift change to status try or is created
      if available_shifts.where.not(user: user).blank? #  there is any other user
        assign_shift_with_user(hour_id, day_id, user_id)
      else # try to assign hours equitative
        if confirmed_shifts.find_by(day_id: day_id, hour_id: hour_id).blank?
          assign_shift_with_user(hour_id, day_id, user_id) #  day is free
        else # day is taken we should evaluate a weight to know if the we should move the current confirmed shift
          create_confirmed_shift(available_shifts, confirmed_shifts, false)
        end
      end
    elsif type == 'update' && !status?
      if available_shifts.where.not(user: user).blank? #  there is any other user
        remove_shift_with_user(hour_id, day_id, user_id)
      else
        create_confirmed_shift(available_shifts, confirmed_shifts, true)
      end
    end
  end

  def remove_shift_with_user(hour_id, day_id, user_id)
    confirmed_shifts.find_or_create_by(
      hour_id: hour_id,
      day_id: day_id,
      user_id: user_id
    ).destroy!
  end

  def create_confirmed_shift(available_shifts, confirmed_shifts, exclude_user)
    #  create a structure with the users with their availables hours by day
    # ex.
    # {
    #   'Ernesto': [7,8,9,10,11,12],
    #   'Bárbara'  [7,8,9,10]
    # }

    employees_availables = {}
    available_shifts_by_day = available_shifts.where(day_id: day_id)
    available_shifts_by_day = available_shifts_by_day.where.not(user_id: user_id) if exclude_user
    available_shifts_by_day = available_shifts_by_day.order(:hour_id)

    available_shifts_by_day.each do |available_shift|
      if employees_availables[available_shift.user_id].blank?
        employees_availables[available_shift.user_id] = {hours: [],
          neighboring_hours_frequency: 0,
          neighboring_hours: [],
          confirmed_shifts: confirmed_shifts.where(user: available_shift.user).where.not(day_id: day_id).count #   Determine the confirmed shifts to extract a weight
        }
      end

      #  Extract the shifts confirmations by employee
      employees_availables[available_shift.user_id][:hours].push(available_shift.hour_id)
    end

    #  Determine the neighboring hours to extract a weight
    employees_availables.each do |user_id, info|
      neighboring_hours_frequency = 0
      neighboring_hours = []

      hours_left = info[:hours].map { |hour| hour if hour < hour_id }.compact.reverse
      hours_rigth = info[:hours].map { |hour| hour if hour > hour_id }.compact

      hours_rigth.each_with_index do |hour, index|
        if (hour - (index + 1)) == hour_id
          neighboring_hours.push(hour)

          neighboring_hours_frequency += 1
        end
      end

      hours_left.each_with_index do |hour, index|
        if (hour + (index + 1)) == hour_id
          neighboring_hours.push(hour)

          neighboring_hours_frequency += 1
        end
      end

      #  Assign a weight if a user already has all the neighboards taken of the current week
      neighboring_hours_weight = 0

      unless neighboring_hours.blank?
        if confirmed_shifts.where(hour_id: neighboring_hours, user_id: user_id, day_id: day_id).count == neighboring_hours_frequency
          neighboring_hours_weight = 1
        end
      end

      employees_availables[user_id][:neighboring_hours_taken] = neighboring_hours_weight
      employees_availables[user_id][:neighboring_hours_frequency] = neighboring_hours_frequency
    end

    #  check for every employee who has more hours confirmed at the moment
    #  sort employees with more confirmed hours at the moment

    #  I gave the following priorities
    # formula -> p = ngp + csp + pn
    #  pn = (1 * 0.20) if the current user has all the week taken
    # p = (0.60 * neighboring_hours_frequency) + (0.40 * |(user_confirmed_shifts - average_confirmed_shifts)|) + pn
    #  based on the priority the day is going to be assigned

    priorities = []
    employees_availables = employees_availables.map do |info|
      info.last.merge(
        user_id: info.first
      )
    end

    employees_availables.sort { |info| info[:confirmed_shifts] }.reverse
    employees_length = employees_availables.length

    confirmed_shifts_average = employees_availables.pluck(:confirmed_shifts).sum / employees_length

    employees_availables.each do |info|
      ngp = (info[:confirmed_shifts] - confirmed_shifts_average).abs * 0.30
      csp = info[:neighboring_hours_frequency] * 0.60
      np = info[:neighboring_hours_taken]
      priority = ngp + csp + np

      priorities.push(
        {
          np: np,
          ngp: ngp,
          csp: csp,
          priority: priority,
          user_id: info[:user_id]
        }
      )
    end

    user_info = priorities.max_by { |info| info[:priority] }

    assign_shift_with_user(hour_id, day_id, user_info[:user_id])
  end

  def assign_shift_with_user(hour_id, day_id, user_id)
    confirmed_shift = working_week.confirmed_shifts.find_or_create_by(
      hour_id: hour_id,
      day_id: day_id
    )

    confirmed_shift.user_id = user_id
    confirmed_shift.save!
  end
end
