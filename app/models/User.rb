class User < ActiveRecord::Base
    has_many :user_tasks
    has_many :tasks, through: :user_tasks

    def tasks_by_week
        weeks = {}
        self.user_tasks.each do |task|
            week_of = task.start_time.beginning_of_week(:sunday)
            weeks[week_of] = [*weeks[week_of], task]
             
        end
        weeks
    end
end