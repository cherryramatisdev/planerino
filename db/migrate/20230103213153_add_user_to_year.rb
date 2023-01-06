class AddUserToYear < ActiveRecord::Migration[7.0]
  def change
    add_reference :years, :user, null: false, foreign_key: true
  end
end
