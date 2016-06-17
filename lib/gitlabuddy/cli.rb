require 'thor'

module Gitlabuddy
  class Cli < Thor
    desc 'projects', 'This will list all your projects on Gitlab'
    def projects
      require 'gitlabuddy/project'
      puts Gitlabuddy::Project.all
    end

    desc 'merge_requests', 'This will list all your merge_requests on Gitlab'
    def merge_requests
      require 'gitlabuddy/merge_request'
      puts Gitlabuddy::MergeRequest.all
    end

    desc 'project_type PROJECT_ID', 'This will return the project type of a certain project'
    def project_type(project_id)
      require 'gitlabuddy/project'
      puts Gitlabuddy::Project.project_type(project_id)
    end
  end
end
