property :name, [String, Array], required: true
property :version, String

action :install do
  version = self.version || node.cocaine.core.default_version
  package_names = Array(name)
  package_file_names = package_names.map { |package_name| "#{package_name}_#{version}*.deb" }
  reference = node.cocaine.core.references[version] || fail('failed to determine reference')

  execute 'true' do
    cwd '/vagrant/pkg'
    not_if { package_file_names.all? { |package_file_name| Dir[::File.join('/vagrant/pkg', package_file_name)].any? } }
    notifies :build, 'git_sources_packages[cocaine-core]', :immediately
  end

  git_sources_packages 'cocaine-core' do
    repository 'git://github.com/cocaine/cocaine-core.git'
    reference reference
    action :nothing
  end

  execute "dpkg -i #{package_file_names.join(' ')} || apt-get --force-yes -y -f install" do
    cwd '/vagrant/pkg'
  end
end
