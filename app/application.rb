class Application
  def call(env)
    req = Rack::Request.new(env)

    if req.path.match(/user=/)
      find_user(req.path.split('=').last)
    else
      send_not_found
    end
  end

  private

  def send_hello
    return [200, { "Content-Type" => "application/json" }, [{ :message => "hello world!" }.to_json]]
  end

  def send_not_found
    return [404, {}, ["Path not found!!!"]]
  end

  def find_user(username_string)
    result =  User.find_by(username: username_string)
    return [200, { "Content-Type" => "application/json" }, [{ :message => result }.to_json]]
  end
end
