class ApplicationSystemController < ApplicationController
  before_action :authenticate_user!
  before_action :set_query

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
end
