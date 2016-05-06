include_recipe 'cocaine::build_plugins'
include_recipe 'cocaine::reverbrain'
include_recipe 'cocaine::core'
include_recipe 'cocaine::libswarm'

execute 'install-cocaine-plugins' do
  cwd Chef::Config[:file_cache_path]
  # cwd '/vagrant/pkg'

  command <<-EOH
dpkg -i *.deb || apt-get --force-yes -y -f install
service cocaine-runtime restart
  EOH
end
