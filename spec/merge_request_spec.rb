require 'spec_helper'
require 'gitlabuddy/merge_request'

describe Gitlabuddy::MergeRequest do
  context 'when having three merge requests open' do
    it 'should return three merge requests in a machine readable format' do
      mock_merge_requests = setup_mocks('spec/responses/merge_requests.json')
      merge_requests = Gitlabuddy::MergeRequest.all

      expect(merge_requests).to eq mock_merge_requests
      expect(JSON.parse(merge_requests).length).to eq 3
    end
  end

  context 'when having two merge requests open and one merge request closed' do
    it 'should return two merge requests in a machine readable format' do
      setup_mocks('spec/responses/merge_requests_with_closed.json')
      merge_requests = Gitlabuddy::MergeRequest.all

      expect(JSON.parse(merge_requests).length).to eq 2
    end
  end

  context 'when having two merge requests for a specific project' do
    it 'should return these two merge requests' do
      project_id = 4
      setup_mocks('spec/responses/merge_requests_by_project.json')
      merge_requests = JSON.parse(Gitlabuddy::MergeRequest.by_project(project_id))

      expect(merge_requests.length).to eq 3

      merge_requests.each do |merge_request|
        expect(merge_request['project_id']).to eq project_id
      end
    end
  end

  def setup_mocks(mock_path)
    mock_response = File.open('spec/responses/projects.json', 'rb').read
    mock_merge_requests = File.open(mock_path, 'rb').read

    create_stub_requests([
                          { url: 'https://gitlab.com/api/v3/projects', response: mock_response },
                          { url: 'https://gitlab.com/api/v3/projects/4/merge_requests', response: mock_merge_requests }
                         ])

    mock_merge_requests
  end

  def create_stub_requests(requests)
    requests.each do |request|
      stub_request(:get, request[:url])
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'gitlab.com', 'Private-Token' => (ENV['GITLAB_PRIVATE_TOKEN']).to_s, 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: request[:response], headers: {})
    end
  end
end
