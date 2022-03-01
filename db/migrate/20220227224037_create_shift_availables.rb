class CreateShiftAvailables < ActiveRecord::Migration[6.1]
  def change
    create_table :shift_availables do |t|
      t.integer :hour_id
      t.integer :day_id
      t.boolean :status

      t.timestamps
    end

    add_reference   :shift_availables, :shift, foreign_key: true
    add_reference   :shift_availables, :user, foreign_key: true
  end
end
