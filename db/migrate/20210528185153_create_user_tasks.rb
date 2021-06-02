class CreateUserTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tasks do |t|
      t.string :start_time
      t.string :end_time
      t.integer :user_id
      t.integer :task_id
      t.boolean :is_complete
      t.integer :priority
      
      t.timestamps
    end
  end
end
