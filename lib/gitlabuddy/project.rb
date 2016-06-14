module Gitlabuddy
  class Project
    require 'gitlabuddy/request'

    def self.all
      JSON.parse(
        Gitlabuddy::Request.new('https://gitlab.com/api/v3/projects')
          .send
          .body
      )
    end

    def self.cookbook?(project_id)
      file = JSON.parse(
        Gitlabuddy::Request.new("https://gitlab.com/api/v3/projects/#{project_id}/repository/files?file_path=metadata.rb&ref=master")
          .send
          .body
      )

      file['file_name'] ? true : false
    end
  end
end
