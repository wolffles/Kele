require 'httparty'
require './lib/roadmap.rb'
class Bapig
  include HTTParty
  include Roadmap

  def initialize(email, password)
    # httparty documentation
    response = self.class.post(base_api_endpoint("sessions"), body: { "email": email, password: password })
    #self.class.post is the same as <class_name>.post
    puts response.code
    raise "invalid email/password " if response.code == 401
    @auth_token = response["auth_token"]
    @auth_user = response["user"]
  end
  #client = Bapig.new(email,password)
  #client.get_me => returns hash object refering to account
  def get_me
    response = self.class.get(base_api_endpoint("users/me"), headers: { :authorization => @auth_token })
    JSON.parse(response.body, symbolize_names: true)
    #JSON.parse is a method that takes a JSON string object, and turns it into a ruby data structure. it basically helps humans read it.
  end

  def get_mentor_availability(mentor_id = 623967) # 623967 is brittany's_id
    response = self.class.get(base_api_endpoint("mentors/#{mentor_id}/student_availability"), headers: {"authorization" => @auth_token})
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_messages(n = nil)
    response = self.class.get(base_api_endpoint("message_threads"), headers: {"authorization" => @auth_token})
    parsed = JSON.parse(response.body, symbolize_names: true)
    n == nil ? parsed : parsed[:items][0..n-1]
  end

  def create_message(sender, recipient_id, subject, text)
    response = self.class.post(base_api_endpoint("messages"), body: {"sender": sender, "recipient_id": recipient_id, "subject": subject, "stripped-text": text }, header: {:authorization => @auth_token})
    puts response.code
    response.body
  end

# hashs can accept assigning like `<variable>: <value>` or `"string": <value>` when calling :<symbols> or "strings"
  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post(base_api_endpoint("checkpoint_submissions"), body: {assignment_branch: assignment_branch, checkpoint_id: checkpoint_id, assignment_commit_link: assignment_commit_link, comment: comment}, header {authorization: @auth_token})
    puts response.code
  end
private

  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end

end
