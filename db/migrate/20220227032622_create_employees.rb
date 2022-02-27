class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string    :first_name
      t.string    :last_name

      t.string    :identity_document_number

      t.bigint    :user_creator_id

      t.timestamps
    end

    add_foreign_key :employees, :users, column: :user_creator_id
  end
end
