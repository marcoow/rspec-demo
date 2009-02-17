class CreateTasks < ActiveRecord::Migration

  def self.up
    create_table :tasks do |t|
      t.string     :title,    :null => false, :limit => 150
      t.boolean    :finished, :null =>false,  :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end

end
