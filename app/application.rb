class Application
  def call(env)
    req = Rack::Request.new(env)

    if req.path.match(/user=/) && req.get?
      find_user(req.path.split('=').last.split('&'))
    elsif req.path.match(/user=/) && req.post?
      new_user(req.path.split('=').last, req)
    elsif req.path.match(/tasks/) && req.get?
      get_tasks
    elsif req.path.match(/newusertask/) && req.post?
      new_user_task(req)
    else
      send_not_found
    end
  end

  private

  def send_not_found
    return [404, {}, ["Path not found!!!"]]
  end

  def find_user(userInfoArray)
    result =  User.find_by(username: userInfoArray.first)
    if !result 
      return [200, { "Content-Type" => "application/json" }, [{error: "User does not exist"}.to_json]]
    elsif result.password == userInfoArray.last
      return [200, { "Content-Type" => "application/json" }, [result.to_json(:include => {:user_tasks => {
        :include => :task
        }})]]
    else 
      return [200, { "Content-Type" => "application/json" }, [{error: "Incorrect password"}.to_json]]
    end
  end

  def new_user(username, req)
    result =  User.find_by(username: username)
    if result 
      return [200, { "Content-Type" => "application/json" }, [{error: "User already exists."}.to_json]]
    else
      user_hash = JSON.parse(req.body.read)
      binding.pry
      new_user = User.create(user_hash) 
      return [201, { "Content-Type" => "application/json" }, [new_user.to_json(:include => {:user_tasks => {
        :include => :task
        }})]]
    end
  end

  def new_user_task(req)
    user_task_hash = JSON.parse(req.body.read)
    user_task_hash["start_time"] = DateTime.parse(user_task_hash["start_time"]).strftime("%l,%P,%A,%U,%B,%d,%Y,%s")
    user_task_hash["end_time"] = DateTime.parse(user_task_hash["end_time"]).strftime("%l,%P,%A,%U,%B,%d,%Y,%s")
    binding.pry
    new_user_task = UserTask.create(user_task_hash)
    return [201, { "Content-Type" => "application/json" }, [new_user_task.to_json]]
  end

  def get_tasks
    return [200, { "Content-Type" => "application/json" }, [Task.all.to_json]]
  end
end
