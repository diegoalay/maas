class UsersController < ApplicationSystemController
  before_action :set_user, only: %i[update destroy]

  # GET /users or /users.json
  def index
    respond_to do |format|
      format.html {}
      format.json do

        respond_with_successful(User.index(current_user, @query))
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json do
        set_user

        return respond_with_not_found unless @user

        respond_with_successful(@user)
      end
    end
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.user_creator = current_user

    if @user.save
      respond_with_successful(@user)
    else
      respond_user_with_errors
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    return respond_with_error("No posee autorización para realizar esta acción.") unless @user.can_edit?(current_user)
    return respond_with_not_found unless @user

    if @user.update(user_params)
      respond_with_successful(@user)
    else
      respond_user_with_errors
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    return respond_with_not_found unless @user

    if @user.destroy
      respond_with_successful(@user)
    else
      respond_user_with_errors
    end
  end

  private

  def respond_user_with_errors
    return respond_with_error(@user.errors.full_messages.to_sentence)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {}).permit(
      %i[first_name last_name]
    )
  end
end