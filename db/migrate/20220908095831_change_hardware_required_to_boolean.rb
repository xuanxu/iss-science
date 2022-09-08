class ChangeHardwareRequiredToBoolean < ActiveRecord::Migration[7.0]
  def change
    remove_column :experiments, :hardware_required, :string
    add_column :experiments, :hardware_required, :boolean, default: false
  end
end
