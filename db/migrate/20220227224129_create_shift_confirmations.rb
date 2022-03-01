class CreateShiftConfirmations < ActiveRecord::Migration[6.1]
  def change
    create_table :shift_confirmations do |t|
      t.integer :hour_id
      t.boolean :status

      t.timestamps
    end

    add_reference   :shift_confirmations, :shift, foreign_key: true
    add_reference   :shift_confirmations, :user, foreign_key: true
  end
end