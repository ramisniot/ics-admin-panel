class AddTargetToTrackers < ActiveRecord::Migration
  def change
    add_column :trackers, :target, :integer
  end
end
