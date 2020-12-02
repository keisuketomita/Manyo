class CreateReads < ActiveRecord::Migration[5.2]
  def change
    create_table :reads do |t|
      t.references :user, foreign_key: true, null: false
      t.references :task, foreign_key: true, null: false
      t.boolean :read

      t.timestamps
    end
    add_index :reads, [:user_id, :task_id], unique: true
  end
end
