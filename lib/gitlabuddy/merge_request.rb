module Gitlabuddy
  class MergeRequest
    require 'gitlabuddy/request'
    require 'gitlabuddy/project'
    require 'json'

    def self.all
      merge_requests = []

      Gitlabuddy::Project.all.each do |project|
        JSON.parse(
          Gitlabuddy::Request.new("https://gitlab.com/api/v3/projects/#{project['id']}/merge_requests")
            .send
            .body
        ).each { |request| merge_requests.push request if request['state'] == 'opened' }
      end

      merge_requests.to_json
    end
  end
end
