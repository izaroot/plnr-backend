class Application
  def call(env)
    req = Rack::Request.new(env)

    if req.path.match(/user=/) && req.get?
      find_user(req.path.split('=').last.split('&'))
    elsif req.path.match(/user=/) && req.post?
      new_user(req.path.split('=').last, req)
    elsif req.path.match(/tasks/) && req.get?
      get_tasks
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
      new_user = User.create(user_hash) 
      return [201, { "Content-Type" => "application/json" }, [new_user.to_json(:include => {:user_tasks => {
        :include => :task
        }})]]
    end
  end

  def get_tasks
    return [200, { "Content-Type" => "application/json" }, [Task.all.to_json]]
  end
end
