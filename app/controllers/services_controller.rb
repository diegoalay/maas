class ServicesController < ApplicationSystemController
  before_action :set_service, only: %i[available_shifts update destroy]
  before_action :validate_admin_role, only: %i[index show create update destroy]

  # GET /services or /services.json
  def index
    respond_to do |format|
      format.html {}
      format.json do

        respond_with_successful(Service.index)
      end
    end
  end

  # GET /services/1 or /services/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json do
        set_service

        return respond_with_not_found unless @service

        respond_with_successful(@service)
      end
    end
  end

  # GET /services/new
  def new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services or /services.json
  def create
    @service = Service.new(service_params)
    @service.user_creator = current_user

    if @service.save
      respond_with_successful(@service)
    else
      respond_service_with_errors
    end
  end

  # PATCH/PUT /services/1 or /services/1.json
  def update
    return respond_with_not_found unless @service

    if @service.update(service_params)
      respond_with_successful(@service)
    else
      respond_service_with_errors
    end
  end

  def available_shifts
    return respond_with_successful(@service.available_shifts)
  end

  # DELETE /services/1 or /services/1.json
  def destroy
    return respond_with_not_found unless @service

    if @service.destroy
      respond_with_successful(@service)
    else
      respond_service_with_errors
    end
  end

  private

  def respond_service_with_errors
    return respond_with_error(@service.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def service_params
    params.fetch(:service, {}).permit(
      :name,
      schedule: [
        :id,
        :start_at,
        :end_at,
        :status
      ]
    )
  end
end
