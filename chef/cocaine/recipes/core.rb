include_recipe 'cocaine::build_core'
include_recipe 'cocaine::cgroups'

execute 'install-cocaine-core' do
  cwd Chef::Config[:file_cache_path]
  # cwd '/vagrant/pkg'

  command <<-EOH
dpkg -i cocaine-dbg_*.deb cocaine-runtime_*.deb libcocaine-core3_*.deb libcocaine-dev_*.deb ||
  apt-get --force-yes -y -f install
  EOH
end
