class ApplicationSystemController < ApplicationController
  before_action :authenticate_user!
  before_action :set_query
  before_action :set_data

  def set_query
    @query = {
      filters: params[:filters],
      pagination: {
        per_page: params[:per_page].to_i||10,
        current_page: params[:current_page].to_i||1,
        order: params[:order] == 'true' ? 'desc' : 'asc',
        order_by: params[:order_by]||'id'
      }
    }
  end

  def set_data
    @data = {
      current_user: {
        id: current_user.id,
        role: current_user.role,
        email: current_user.email,
        name: current_user.full_name
      }
    }
  end

  def validate_admin_role
    unless current_user.admin?
      respond_to do |format|
        format.html {
          redirect_to working_weeks_path
        }
        format.json do

          return respond_with_error("No tienes permisos para realizar esta acción") unless current_user.admin?
        end
      end
    end
  end
end
