class CreateMailstatuses < ActiveRecord::Migration
  def self.up
    create_table :mailstatuses do |t|
      t.column :project_id, :integer
      t.column :begin_status, :string
      t.column :end_status, :string
    end
  end

  def self.down
    drop_table :mailstatuses
  end
end
