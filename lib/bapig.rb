require 'httparty'
class Bapig
  include HTTParty


  def initialize(email, password)
    # httparty documentation
    response = self.class.post(base_api_endpoint("sessions"), body: { "email": email, "password": password })
    #self.class.post is the same as <class_name>.post
    puts response.code
    raise "invalid email/password " if response.code == 401
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(base_api_endpoint("users/me"), headers: { "authorization" => @auth_token })
  end


private

  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end

end
