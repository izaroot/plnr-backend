class UserTask < ActiveRecord::Base
    belongs_to :user
    belongs_to :task

    def self.user_task 
        self.all.max_by do |task|
            task.user_tasks.count
        end
    end

    def self.today_tasks
        self.all.filter do |task|
            Time.at(task.start_time.split(',').last.to_i).wday == Date.today.wday
        end
    end

    def self.most_popular_today
        idArr = self.today_tasks.map{|task| task.task_id}
        # self.today_tasks.max_by do |task|
        #     self.today_tasks.count(task.task_id)
        # end
       
        self.today_tasks.filter do |task|
            task.task_id ===  idArr.max_by{|id| idArr.count(id)}
        end.first.task
    end
end