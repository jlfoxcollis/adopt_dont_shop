class Changecolumn < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:applications, :application_status, from: nil, to: 0)
  end
end
