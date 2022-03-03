class CreateWorkingWeekAvailableShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :working_week_available_shifts do |t|
      t.integer :hour_id
      t.integer :day_id
      t.boolean :status

      t.timestamps
    end

    add_index :working_week_available_shifts, :day_id
    add_index :working_week_available_shifts, :hour_id

    add_reference :working_week_available_shifts, :working_week, foreign_key: true
    add_reference :working_week_available_shifts, :user, foreign_key: true
  end
end
