class UserTask < ActiveRecord::Base
    belongs_to :user
    belongs_to :task

    def day_of_week
        self.start_time.wday
    end
end