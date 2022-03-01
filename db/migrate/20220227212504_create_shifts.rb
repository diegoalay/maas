class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.integer :week_id

      t.timestamps
    end

    add_reference   :shifts, :service, foreign_key: true
  end
end
