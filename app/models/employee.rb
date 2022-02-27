class Employee < ApplicationRecord
  belongs_to :user_creator, class_name: "User", foreign_key: "user_creator_id"

  def self.index(query)
    search = query[:filters][:search]&.downcase.to_s

    employees = Employee.select("
      employees.id,
      employees.created_at,
      trim(
        concat(
          employees.first_name,
          ' ',
          employees.last_name
        )
      ) as full_name,
      trim(
        concat(
          users.first_name,
          ' ',
          users.last_name
        )
      ) as user_creator_name,
      employees.identity_document_number
    ")
    .joins(:user_creator)

    employees = employees.where("
      lower(employees.first_name) like '%#{search}%' or
      lower(employees.last_name) like '%#{search}%' or
      concat(
        lower(employees.first_name),
          ' ',
        lower(employees.last_name)
      ) like '%#{search}%' or
      employees.identity_document_number like '%#{search}%'
    ") unless search.blank?

    employees = employees.page(query[:pagination][:current_page])
    .per(query[:pagination][:per_page])
    .order("#{query[:pagination][:order_by]} #{query[:pagination][:order]} nulls last")

    {
      current_page: employees.current_page,
      total_pages: employees.total_pages,
      total_count: employees.total_count,
      total_lenght: employees.length,
      employees: employees
    }
  end
end
