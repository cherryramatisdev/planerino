class AddYearToMonth < ActiveRecord::Migration[7.0]
  def change
    add_reference :months, :year, null: true, foreign_key: true
  end
end
