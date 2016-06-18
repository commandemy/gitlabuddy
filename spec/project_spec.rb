require 'spec_helper'
require 'gitlabuddy/project'

describe Gitlabuddy::Project do
  context 'when being a member of multiple projects' do
    it 'should return all the projects I am a member of' do
      mock_response = setup_mock('projects.json', 'https://gitlab.com/api/v3/projects')

      expect(Gitlabuddy::Project.all).to eq mock_response
    end
  end

  context 'when looking at a specific project' do
    it 'should know if the project is a cookbook' do
      project_id = 4
      setup_mock('project_is_cookbook.json', "https://gitlab.com/api/v3/projects/#{project_id}/repository/tree")

      expect(Gitlabuddy::Project.project_type(project_id)).to eq 'cookbook'
    end

    it 'should know if the project is a normal ruby project' do
      project_id = 6
      setup_mock('project_is_ruby.json', "https://gitlab.com/api/v3/projects/#{project_id}/repository/tree")

      expect(Gitlabuddy::Project.project_type(project_id)).to eq 'ruby'
    end

    it 'should know if the project is unknown' do
      project_id = 8
      setup_mock('project_is_unknown.json', "https://gitlab.com/api/v3/projects/#{project_id}/repository/tree")

      expect(Gitlabuddy::Project.project_type(project_id)).to eq 'unknown'
    end
  end

  context 'when looking at the branches of a specific project' do
    it 'should return the branches' do
      project_id = 3
      mock_response = setup_mock('project_branches.json', "https://gitlab.com/api/v3/projects/#{project_id}/repository/branches")

      expect(Gitlabuddy::Project.branches(project_id)).to eq mock_response
    end
  end

  context 'when requesting a full dump of all my project data' do
    it 'should return that dump' do
      mock_response = File.open('spec/responses/project_dump.json', 'rb').read

      setup_mock('projects.json', 'https://gitlab.com/api/v3/projects')
      setup_mock('project_is_cookbook.json', 'https://gitlab.com/api/v3/projects/4/repository/tree')
      setup_mock('merge_requests.json', 'https://gitlab.com/api/v3/projects/4/merge_requests')
      setup_mock('project_branches.json', 'https://gitlab.com/api/v3/projects/4/repository/branches')

      expect(Gitlabuddy::Project.dump).to eq mock_response
    end
  end

  # Update method before doing context above
  def setup_mock(mock_path, request_path)
    mock_response = File.open("spec/responses/#{mock_path}", 'rb').read

    stub_request(:get, request_path)
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'gitlab.com', 'Private-Token' => (ENV['GITLAB_PRIVATE_TOKEN']).to_s, 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: mock_response, headers: {})

    mock_response
  end
end
