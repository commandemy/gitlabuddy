module Gitlabuddy
  class Project
    require 'gitlabuddy/request'
    require 'json'

    def self.all
      projects = JSON.parse(
        Gitlabuddy::Request.new('https://gitlab.com/api/v3/projects')
          .send
          .body
      )

      projects.to_json
    end

    def self.project_type(project_id)
      files = JSON.parse(
        Gitlabuddy::Request.new("https://gitlab.com/api/v3/projects/#{project_id}/repository/tree")
          .send
          .body
      )

      type = case files.to_s
             when /Gemfile/
               'ruby'
             when /metadata.rb/
               'cookbook'
             else
               'unknown'
             end

      type
    end
  end
end
