include_recipe 'cocaine'
include_recipe 'rbenv'
include_recipe 'rbenv::ruby_build'

rbenv_ruby '2.3.0' do
  global true
end

rbenv_gem 'bundler' do
  ruby_version '2.3.0'
end

bash 'Bundling ruby example' do
  cwd '/vagrant/examples/ruby'
  code 'bundle install'
end

bash 'Installing ruby example' do
  cwd '/vagrant/examples/ruby'
  code 'cocaine-tool app upload && cocaine-tool app restart --name ruby --profile default'
end
