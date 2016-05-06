bash 'Turn on reverbrain repo' do
  code <<-EOH
cp -v /vagrant/chef/cocaine/repo.reverbrain.conf /etc/apt/sources.list.d/reverbrain.list

curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add -

echo ""

apt-get update
  EOH
end
