class Shift < ApplicationRecord
  belongs_to :service

  has_many :confirmations
  has_many :availables

  def self.options(query)
    {
      services: Service.all.map{|service| {schedule: service.schedule, text: service.name, value: service.id}},
      employees: User.where(role: "employee").map{
        |user| {
          full_name: user.full_name,
          color: user.color,
          id: user.id
        }
      },
    }
  end

  def self.create_shift(service, week)
    Shift.find_or_create_by(
      service: service,
      week_id: week
    )
  end
end