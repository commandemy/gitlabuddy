require 'spec_helper'
require 'gitlabuddy/request'

describe Gitlabuddy::Request do
  context 'when I make a HTTP request' do
    it 'returns a correct reponse' do
      mock_response = File.open('spec/responses/request.json', 'rb').read
      url = 'http://myrequest.com'

      stub_request(:get, url)
        .to_return(status: 200, body: mock_response, headers: {})

      request = Gitlabuddy::Request.new(url)
      response = request.send

      expect(response.code).to eq '200'
      expect(response.body).to eq mock_response
    end
  end
end
