include_recipe 'cocaine::core'
include_recipe 'cocaine::plugins'
include_recipe 'cocaine::tools'

bash 'Configure cocaine' do
  code 'cp /vagrant/examples/cocaine.conf /etc/cocaine/cocaine-default.conf && service cocaine-runtime restart'
end

bash 'Creating cocaine app control objects' do
  code <<-EOH
  cocaine-tool runlist create --name default
  cocaine-tool profile upload --name default --profile='{"pool-limit": 4, "isolate": {"type": "process", "args": {"spool": "/var/spool/cocaine"}}}'
  EOH
end

bash 'Bootstrapping' do
  code 'cocaine-tornado-proxy --port=80 start &'
end
