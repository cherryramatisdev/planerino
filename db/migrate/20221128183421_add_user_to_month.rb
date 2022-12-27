class AddUserToMonth < ActiveRecord::Migration[7.0]
  def change
    add_reference :months, :user, null: false, foreign_key: true
  end
end
