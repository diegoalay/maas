class EmployeesController < ApplicationSystemController
  before_action :set_employee, only: %i[update destroy]

  # GET /employees or /employees.json
  def index
    respond_to do |format|
      format.html {}
      format.json do

        respond_with_successful(Employee.index(@query))
      end
    end
  end

  # GET /employees/1 or /employees/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json do
        set_employee

        return respond_with_not_found unless @employee

        respond_with_successful(@employee)
      end
    end
  end

  # GET /employees/new
  def new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.user_creator = current_user

    if @employee.save
      respond_with_successful(@employee)
    else
      respond_employee_with_errors
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    return respond_with_not_found unless @employee

    if @employee.update(employee_params)
      respond_with_successful(@employee)
    else
      respond_employee_with_errors
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    return respond_with_not_found unless @employee

    if @employee.destroy
      respond_with_successful(@employee)
    else
      respond_employee_with_errors
    end
  end

  private

  def respond_employee_with_errors
    return respond_with_error(@employee.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.fetch(:employee, {}).permit(
      %i[first_name last_name identity_document_number]
    )
  end
end