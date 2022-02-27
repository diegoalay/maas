class ApplicationSystemController < ApplicationController
  before_action :authenticate_user!
  before_action :set_query
  before_action :set_data

  def set_query
    @query = {
      filters: params[:filters],
      pagination: {
        per_page: (params[:per_page] ? params[:per_page].to_i : 10),
        current_page: (params[:current_page] ? params[:current_page].to_i : 1),
        order: (params[:order]  == "true" ? "desc" : "asc"),
        order_by: (params[:order_by] ? params[:order_by] : "id"),
      }
    }
  end

  def set_data
    @data = {
      current_user: {
        id: current_user.id,
        role: current_user.role,
        email: current_user.email,
        name: current_user.full_name,
      }
    }
  end
end
