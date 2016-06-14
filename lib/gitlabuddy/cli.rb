require 'thor'

module Gitlabuddy
  class Cli < Thor
    desc 'projects', 'This will list all your projects on Gitlab'
    def projects
      require 'gitlabuddy/project'
      Gitlabuddy::Project.all
    end

    desc 'merge_requests', 'This will list all your merge_requests on Gitlab'
    def merge_requests
      require 'gitlabuddy/merge_request'
      Gitlabuddy::MergeRequest.all
    end

    desc 'cookbook PROJECT_ID', 'This will check if a certain project is a cookbook'
    def cookbook(project_id)
      require 'gitlabuddy/project'
      Gitlabuddy::Project.cookbook?(project_id)
    end
  end
end
