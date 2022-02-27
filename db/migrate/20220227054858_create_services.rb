class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string    :name
      t.bigint    :user_creator_id

      t.timestamps
    end

    add_foreign_key :services, :users, column: :user_creator_id
  end
end
