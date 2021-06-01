class Application
  def call(env)
    req = Rack::Request.new(env)

    if req.path.match(/user=/)
      find_user(req.path.split('=').last.split('&'))
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
      return [200, { "Content-Type" => "application/json" }, [result.to_json]]
    else 
      return [200, { "Content-Type" => "application/json" }, [{error: "Incorrect password"}.to_json]]
    end
  end
end
