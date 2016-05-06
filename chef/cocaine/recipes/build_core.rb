package 'git'
package 'devscripts'
package 'equivs'

repo_dir = File.join(Chef::Config[:file_cache_path], 'cocaine-core')

git repo_dir do
  repository 'git://github.com/cocaine/cocaine-core.git'
  reference 'c7896c0e92200fed1ebf1a7980a03e902ddee69c'
  enable_submodules true
  action :sync
  notifies :run, 'execute[build-cocaine-core]', :immediately
end

execute 'build-cocaine-core' do
  cwd repo_dir
  command <<-EOH
mk-build-deps -irt 'apt-get --force-yes -y'
dpkg-buildpackage
  EOH
  action :nothing
end
