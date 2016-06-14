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

      puts projects
      projects
    end

    def self.cookbook?(project_id)
      file = JSON.parse(
        Gitlabuddy::Request.new("https://gitlab.com/api/v3/projects/#{project_id}/repository/files?file_path=metadata.rb&ref=master")
          .send
          .body
      )

      is_cookbook = file['file_name'] ? true : false

      puts is_cookbook
      is_cookbook
    end
  end
end
