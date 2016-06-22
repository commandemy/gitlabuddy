Gem::Specification.new do |s|
  s.name        = 'gitlabuddy'
  s.version     = '0.0.5'
  s.date        = '2016-06-22'
  s.summary     = 'Gitlabuddy!'
  s.description = 'A gem to interact with GitLab'
  s.authors     = ['Infralovers']
  s.email       = 'team@infralovers.com'
  s.files       = [
    'lib/gitlabuddy.rb',
    'lib/gitlabuddy/request.rb',
    'lib/gitlabuddy/project.rb',
    'lib/gitlabuddy/merge_request.rb',
    'lib/gitlabuddy/cli.rb'
  ]
  s.homepage    = 'https://rubygems.org/gems/gitlabuddy'
  s.license     = 'MIT'
  s.executables = 'gitlabuddy'
  s.add_dependency 'thor', '~> 0.19.1'
end
