class WorkingWeek < ApplicationRecord
  belongs_to :service

  has_many :confirmed_shifts, dependent: :destroy
  has_many :available_shifts, dependent: :destroy

  def self.options(query)
    {
      services: Service.all.map {|service| { schedule: service.schedule, text: service.name, value: service.id }},
      employees: User.where(role: 'employee').map { |user| { full_name: user.full_name, color: user.color, id: user.id }}
    }
  end

  def self.create_shift(service, week)
    WorkingWeek.find_or_create_by(
      service: service,
      week_id: week
    )
  end
end