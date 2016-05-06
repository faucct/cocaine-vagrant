include_recipe 'cocaine::core'
include_recipe 'cocaine::framework-python'

package 'git'

python_pip 'git+git://github.com/cocaine/cocaine-tools.git@dbc01a9198ea2ab288d1fa3ea3f237896dffa0ac' do
  action :install
end
