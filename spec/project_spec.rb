require 'spec_helper'
require 'gitlabuddy/project'

describe Gitlabuddy::Project do
  context 'when being a member of multiple projects' do
    it 'returns all the projects I am a member of' do
      mock_response = File.open('spec/responses/projects.json', 'rb').read

      stub_request(:get, 'https://gitlab.com/api/v3/projects')
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'gitlab.com', 'Private-Token' => (ENV['GITLAB_PRIVATE_TOKEN']).to_s, 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: mock_response, headers: {})

      expect(Gitlabuddy::Project.all).to eq JSON.parse(mock_response)
    end
  end

  context 'when looking at a specific project' do
    it 'should know if the project is a cookbook' do
      project_id = 4
      setup_mocks('spec/responses/project_is_cookbook.json', project_id)

      expect(Gitlabuddy::Project.project_type(project_id)).to eq 'cookbook'
    end

    it 'should know if the project is a normal ruby project' do
      project_id = 6
      setup_mocks('spec/responses/project_is_ruby.json', project_id)

      expect(Gitlabuddy::Project.project_type(project_id)).to eq 'ruby'
    end

    it 'should know if the project is unknown' do
      project_id = 8
      setup_mocks('spec/responses/project_is_unknown.json', project_id)

      expect(Gitlabuddy::Project.project_type(project_id)).to eq 'unknown'
    end
  end

  def setup_mocks(mock_path, project_id)
    mock_response = File.open(mock_path, 'rb').read

    stub_request(:get, "https://gitlab.com/api/v3/projects/#{project_id}/repository/tree")
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'gitlab.com', 'Private-Token' => (ENV['GITLAB_PRIVATE_TOKEN']).to_s, 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: mock_response, headers: {})

    mock_response
  end
end
