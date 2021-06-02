class User < ActiveRecord::Base
    has_many :user_tasks
    has_many :tasks, through: :user_tasks

    def task_by_day
        self.user_tasks.group_by do |task|
            task.start_time.yday
        end.sort
    end

    def tasks_by_week
        # self.user_tasks.group_by do |task|
        #     task.start_time.beginning_of_week(:sunday)
        # end
        self.task_by_day.group_by do |day|
            day[1][0].start_time.beginning_of_week(:sunday)
        end
    end

end