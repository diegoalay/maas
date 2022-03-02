class CreateWorkingWeeks < ActiveRecord::Migration[6.1]
  def change
    create_table :working_weeks do |t|
      t.integer :week_id

      t.timestamps
    end

    add_reference   :working_weeks, :service, foreign_key: true
  end
end
