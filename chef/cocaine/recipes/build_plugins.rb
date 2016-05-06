include_recipe 'cocaine::reverbrain'
include_recipe 'cocaine::core'
include_recipe 'cocaine::libswarm'

package 'git'
package 'devscripts'
package 'equivs'

repo_dir = File.join(Chef::Config[:file_cache_path], 'cocaine-plugins')

git repo_dir do
  repository 'git://github.com/cocaine/cocaine-plugins.git'
  reference 'ed792ec31a1771cd3e7e835b650adf1c9083087c'
  enable_submodules true
  action :sync
  notifies :run, 'execute[build-cocaine-plugins]', :immediately
end

execute 'build-cocaine-plugins' do
  cwd repo_dir
  command <<-EOH
mk-build-deps -irt 'apt-get --force-yes -y'
dpkg-buildpackage
  EOH
  action :nothing
end
