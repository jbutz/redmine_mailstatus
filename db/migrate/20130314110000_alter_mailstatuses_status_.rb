class AlterMailstatusesStatus < ActiveRecord::Migration
  def self.up
    change_column(:mailstatuses, :begin_status, :integer)
    change_column(:mailstatuses, :end_status, :integer)
  end

  def self.down
    change_column(:mailstatuses, :begin_status, :string)
    change_column(:mailstatuses, :end_status, :string)
  end
end
