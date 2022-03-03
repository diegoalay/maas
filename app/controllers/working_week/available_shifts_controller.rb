class WorkingWeek::AvailableShiftsController < ApplicationSystemController
  before_action :set_working_week, only: %i[index create]
  before_action :set_available_shift, only: %i[update destroy]

  # GET /working_weeks/:working_week_id/available_shifts.json
  def index
    respond_to do |format|
      format.json do

        respond_with_successful(@working_week.available_shifts)
      end
    end
  end

  # POST /working_weeks/:working_week_id/available_shifts.json
  def create
    return respond_with_error('No tiene permisos para realizar esta acción.') unless user_is_granted?

    @available_shift = @working_week.available_shifts.new(working_week_params)

    if @available_shift.save
      respond_with_successful(@available_shift)
    else
      respond_available_shift_with_errors
    end
  end

  # PATCH/PUT /working_weeks/:working_week_id/available_shifts/:id.json
  def update
    return respond_with_error('No tiene permisos para realizar esta acción.') unless user_is_granted?

    return respond_with_not_found unless @available_shift

    if @available_shift.update(working_week_params)
      respond_with_successful(@available_shift)
    else
      respond_available_shift_with_errors
    end
  end

  private

  def user_is_granted?
    return (working_week_params[:user_id] == current_user || current_user.admin?)
  end

  def respond_available_shift_with_errors
    return respond_with_error(@available_shift.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_working_week
    @working_week = WorkingWeek.find_by(id: params[:working_week_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_available_shift
    set_working_week

    return respond_with_not_found unless @working_week
    @available_shift = @working_week.available_shifts.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def working_week_params
    params.fetch(:available_shift, {}).permit(%i[hour_id user_id day_id status])
  end
end