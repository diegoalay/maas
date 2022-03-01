class ShiftsController < ApplicationSystemController
  before_action :set_shift, only: %i[update destroy]

  # GET /shifts or /shifts.json
  def index
    respond_to do |format|
      format.html {}
      format.json do

        respond_with_successful(Shift.index())
      end
    end
  end

  # GET /shifts/1 or /shifts/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json do
        set_shift

        return respond_with_not_found unless @shift

        respond_with_successful(@shift)
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
    @shift = Shift.new(shift_params)

    if @shift.save
      respond_with_successful(@shift)
    else
      respond_shift_with_errors
    end
  end

  # PATCH/PUT /shifts/1 or /shifts/1.json
  def update
    return respond_with_not_found unless @shift

    if @shift.update(shift_params)
      respond_with_successful(@shift)
    else
      respond_shift_with_errors
    end
  end

  # DELETE /shifts/1 or /shifts/1.json
  def destroy
    return respond_with_not_found unless @shift

    if @shift.destroy
      respond_with_successful(@shift)
    else
      respond_shift_with_errors
    end
  end

  def options
    respond_with_successful(Shift.options(@query))
  end

  private

  def respond_shift_with_errors
    return respond_with_error(@shift.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_shift
    @shift = Shift.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shift_params
    params.fetch(:shift, {}).permit(
      :name,
      schedule: [
        :start_at,
        :end_at,
        :status,
      ]
    )
  end
end