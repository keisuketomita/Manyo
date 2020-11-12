class AddPriorityToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :srting, null: false, default: "低"
  end
end
