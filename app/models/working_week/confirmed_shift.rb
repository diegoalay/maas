class WorkingWeek::ConfirmedShift < ApplicationRecord
  belongs_to :working_week
  belongs_to :user

end
