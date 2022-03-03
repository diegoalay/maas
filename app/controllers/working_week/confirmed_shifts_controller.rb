
class WorkingWeek::ConfirmedShiftsController < ApplicationSystemController
  before_action :set_working_week, only: %i[index]

  # GET /working_weeks/:working_week_id/confirmed_shifts.json
  def index
    respond_to do |format|
      format.json do

        respond_with_successful(@working_week.confirmed_shifts)
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_working_week
    @working_week= WorkingWeek.find_by(id: params[:working_week_id])
  end
end