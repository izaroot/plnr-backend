class Task < ActiveRecord::Base
    has_many :user_tasks
    has_many :users, through: :user_tasks

    def self.most_popular
        self.all.max_by do |task|
            task.user_tasks.count
        end
    end

    def self.today_tasks
        self.all.filter do |task|
            Time.at(task.user_tasks.start_time.split(',').last.to_i).wday == Date.today.wday
        end
    end
end