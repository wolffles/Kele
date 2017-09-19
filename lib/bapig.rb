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
  #client = Bapig.new(email,password)
  #client.get_me => returns hash object refering to account
  def get_me
    response = self.class.get(base_api_endpoint("users/me"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body,symbolize_names: true)
    #JSON.parse is a method that takes a JSON string object, and turns it into a ruby data structure. it basically helps humans read it. 
  end


private

  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end

end
