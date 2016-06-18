module Gitlabuddy
  class MergeRequest
    require 'gitlabuddy/request'
    require 'gitlabuddy/project'
    require 'json'

    def self.all
      merge_requests = []

      JSON.parse(Gitlabuddy::Project.all).each do |project|
        JSON.parse(
          by_project(project['id'])
        ).each { |merge_request| merge_requests.push merge_request if merge_request['state'] == 'opened' }
      end

      merge_requests.to_json
    end

    def self.by_project(project_id)
      Gitlabuddy::Request.new("https://gitlab.com/api/v3/projects/#{project_id}/merge_requests")
        .send
        .body
    end
  end
end
