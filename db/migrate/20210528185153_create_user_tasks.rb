class CreateUserTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tasks do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.integer :task_id
      t.boolean :is_complete
      t.integer :priority
      
      t.timestamps
    end
  end
end
