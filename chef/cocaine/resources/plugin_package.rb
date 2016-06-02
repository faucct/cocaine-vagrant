property :name, [String, Array], required: true
property :version, String

action :install do
  version = self.version || node.cocaine.plugins.default_version
  package_names = Array(name)
  package_file_names = package_names.map { |package_name| "#{package_name}_#{version}*.deb" }
  reference = node.cocaine.plugins.references[version] || fail('failed to determine reference')

  execute 'true' do
    cwd '/vagrant/pkg'
    not_if { package_file_names.all? { |package_file_name| Dir[::File.join('/vagrant/pkg', package_file_name)].any? } }
    notifies :run, 'bash[Turn on reverbrain repo]', :immediately
    notifies :install, 'package[libswarm]', :immediately
    notifies :install, 'cocaine_core_package[libcocaine-dev]', :immediately
    notifies :build, 'git_sources_packages[cocaine-plugins]', :immediately
  end

  bash 'Turn on reverbrain repo' do
    code <<-EOH
      cp -v /vagrant/chef/cocaine/repo.reverbrain.conf /etc/apt/sources.list.d/reverbrain.list
      curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add -
      echo ""
      apt-get update
    EOH
    action :nothing
  end

  # FIXME: mk-build-deps cannot resolve the correct libswarm-dev version
  package 'libswarm' do
    package_name %w(libswarm2 libswarm2-xml libswarm2-urlfetcher libswarm-dev)
    version 4.times.map { '0.6.3.0' }
    action :nothing
  end

  cocaine_core_package 'libcocaine-dev' do
    action :nothing
  end

  git_sources_packages 'cocaine-plugins' do
    repository 'git://github.com/cocaine/cocaine-plugins.git'
    reference reference
    action :nothing
  end

  execute "dpkg -i #{package_file_names.join(' ')} || apt-get --force-yes -y -f install" do
    cwd '/vagrant/pkg'
  end
end
