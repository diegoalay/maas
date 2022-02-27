class Service < ApplicationRecord
  belongs_to :user_creator, class_name: "User", foreign_key: "user_creator_id"

  def self.index
    services = Service.select("
      services.id,
      services.created_at,
      services.name,
      trim(
        concat(
          users.first_name,
          ' ',
          users.last_name
        )
      ) as user_creator_name
    ")
    .joins(:user_creator)
  end
end
