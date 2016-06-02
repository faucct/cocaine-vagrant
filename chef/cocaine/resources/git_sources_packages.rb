resource_name :git_sources_packages

property :repository, String, required: true
property :version, String
property :reference, String, default: 'master'

action :build do
  properties = self

  package %w(git devscripts equivs)

  destination = ::File.join(Chef::Config[:file_cache_path], properties.name)

  git name do
    repository properties.repository
    destination destination
    enable_submodules true
  end

  bash "build #{name}@#{reference}" do
    cwd destination
    code <<-EOH
      git checkout #{reference}
      mk-build-deps -irt 'apt-get --force-yes -y'
      dpkg-buildpackage
      cd ..
      mv *.deb /vagrant/pkg
    EOH
  end
end
