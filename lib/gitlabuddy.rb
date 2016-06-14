require 'gitlabuddy/request'
require 'gitlabuddy/project'

=begin
class Gitlabuddy
  require 'net/http'

  def self.projects
    url = URI('https://gitlab.com/api/v3/projects')
    req = Net::HTTP::Get.new(url)
    req['PRIVATE-TOKEN'] = ENV['GITLAB_PRIVATE_TOKEN']

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.request(req)
  end

  def self.merge_requests
  end
end
=end
