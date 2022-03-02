class WorkingWeek::ConfirmedShiftsController < ApplicationSystemController
  before_action :set_working_week, only: %i[index create]
  before_action :set_confirmed_shift, only: %i[update show destroy]

  # GET /working_weeks/:working_week_id/confirmed_shifts.json
  def index
    respond_to do |format|
      format.json do

        respond_with_successful(@working_week.confirmed_shifts)
      end
    end
  end

  # GET /working_weeks/:working_week_id/confirmed_shifts/:id.json
  def show
    respond_to do |format|
      format.json do
        set_working_week

        return respond_with_not_found unless @confirmed_shift

        respond_with_successful(@confirmed_shift)
      end
    end
  end

  # POST /working_weeks/:working_week_id/confirmed_shifts.json
  def create
    @confirmed_shift = @working_week.confirmed_shifts.new(working_week_params)

    if @confirmed_shift.save
      respond_with_successful(@confirmed_shift)
    else
      respond_confirmed_shift_with_errors
    end
  end

  # PATCH/PUT /working_weeks/:working_week_id/confirmed_shifts/:id.json
  def update
    return respond_with_not_found unless @confirmed_shift

    if @confirmed_shift.update(working_week_params)
      respond_with_successful(@confirmed_shift)
    else
      respond_confirmed_shift_with_errors
    end
  end

  # DELETE /working_weeks/:working_week_id/confirmed_shifts/:id.json
  def destroy
    return respond_with_not_found unless @confirmed_shift

    if @confirmed_shift.destroy
      respond_with_successful(@confirmed_shift)
    else
      respond_confirmed_shift_with_errors
    end
  end

  private

  def respond_confirmed_shift_with_errors
    return respond_with_error(@confirmed_shift.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_working_week
    @working_week= WorkingWeek.find_by(id: params[:working_week_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_confirmed_shift
    set_working_week

    return respond_with_not_found unless @working_week
    @confirmed_shift = @working_week.confirmed_shifts.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def working_week_params
    params.fetch(:confirmed_shift, {}).permit(
      %i[hour_id user_id day_id status]
    )
  end
end