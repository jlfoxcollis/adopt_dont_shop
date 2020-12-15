class UpdateColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :application_status
    add_column :applications, :application_status, :integer, default: 0
  end
end
