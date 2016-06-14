module Gitlabuddy
  class Request
    require 'net/http'

    def initialize(url)
      @url = URI(url)
    end

    def send
      req = Net::HTTP::Get.new(@url)
      req['PRIVATE-TOKEN'] = ENV['GITLAB_PRIVATE_TOKEN']
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = (@url.scheme == 'https')
      http.request(req)
    end
  end
end
