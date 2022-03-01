class Shift::AvailablesController < ApplicationSystemController
  before_action :set_shift, only: %i[index create]
  before_action :set_shift_available, only: %i[update show destroy]

  # GET /shifts or /shifts.json
  def index
    respond_to do |format|
      format.html {}
      format.json do

        respond_with_successful(@shift.availables)
      end
    end
  end

  # GET /shifts/1 or /shifts/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json do
        set_shift

        return respond_with_not_found unless @shift_available

        respond_with_successful(@shift_available)
      end
    end
  end

  # GET /shifts/new
  def new
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts or /shifts.json
  def create
    @shift_available = @shift.availables.new(shift_params)

    if @shift_available.save
      respond_with_successful(@shift_available)
    else
      respond_shift_available_with_errors
    end
  end

  # PATCH/PUT /shifts/1 or /shifts/1.json
  def update
    return respond_with_not_found unless @shift_available

    if @shift_available.update(shift_params)
      respond_with_successful(@shift_available)
    else
      respond_shift_available_with_errors
    end
  end

  # DELETE /shifts/1 or /shifts/1.json
  def destroy
    return respond_with_not_found unless @shift_available

    if @shift_available.destroy
      respond_with_successful(@shift_available)
    else
      respond_shift_available_with_errors
    end
  end

  private

  def respond_shift_available_with_errors
    return respond_with_error(@shift_available.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_shift
    @shift= Shift.find_by(id: params[:shift_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_shift_available
    set_shift

    return respond_with_not_found unless @shift
    @shift_available = @shift.availables.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shift_params
    params.fetch(:shift_available, {}).permit(
      %i[hour_id user_id day_id status]
    )
  end
end