class WorkingWeeksController < ApplicationSystemController
  before_action :set_working_week, only: %i[update destroy]

  # GET /working_weeks or /working_weeks.json
  def index
    respond_to do |format|
      format.html {}
      format.json do

        respond_with_successful(WorkingWeek.index)
      end
    end
  end

  # GET /working_weeks/1 or /working_weeks/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json do
        set_working_week

        return respond_with_not_found unless @working_week

        respond_with_successful(@working_week)
      end
    end
  end

  # GET /working_weeks/new
  def new
  end

  # GET /working_weeks/1/edit
  def edit
  end

  # POST /working_weeks or /working_weeks.json
  def create
    @working_week = WorkingWeek.new(working_week_params)

    if @working_week.save
      respond_with_successful(@working_week)
    else
      respond_working_week_with_errors
    end
  end

  # PATCH/PUT /working_weeks/1 or /working_weeks/1.json
  def update
    return respond_with_not_found unless @working_week

    if @working_week.update(working_week_params)
      respond_with_successful(@working_week)
    else
      respond_working_week_with_errors
    end
  end

  # DELETE /working_weeks/1 or /working_weeks/1.json
  def destroy
    return respond_with_not_found unless @working_week

    if @working_week.destroy
      respond_with_successful(@working_week)
    else
      respond_working_week_with_errors
    end
  end

  def options
    respond_with_successful(WorkingWeek.options(@query))
  end

  private

  def respond_working_week_with_errors
    respond_with_error(@working_week.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_working_week
    @working_week = WorkingWeek.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def working_week_params
    params.fetch(:working_week, {}).permit(
      :name,
      schedule: [
        :start_at,
        :end_at,
        :status
      ]
    )
  end
end