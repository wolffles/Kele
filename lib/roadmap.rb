module Roadmap

    def get_roadmaps(roadmap_id = 38)#<class object>.get_me[:current_enrollment][:roadmap_id]
      response = self.class.get(base_api_endpoint("roadmaps/#{roadmap_id}"), headers: {:authorization => @auth_token })
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_checkpoint(id)
      response = self.class.get(base_api_endpoint("checkpoints/#{id}"),
        headers: {:authorization => @auth_token })
      JSON.parse(response.body, symbolize_names: true)
    end

end
