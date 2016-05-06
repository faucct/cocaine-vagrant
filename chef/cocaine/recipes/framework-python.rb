include_recipe 'python'

package 'git'

python_pip 'git+git://github.com/cocaine/cocaine-framework-python.git@0089f3f137927ec37686ea581a3f389bac4e6a2c' do
  action :install
end
