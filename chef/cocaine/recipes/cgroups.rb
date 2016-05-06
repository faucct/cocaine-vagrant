bash 'Mount the cgroups' do
  code <<-EOH
    mount -t tmpfs cgroup_root /sys/fs/cgroup
    mkdir /sys/fs/cgroup/cpuset
    mount -t cgroup cpuset -o cpuset /sys/fs/cgroup/cpuset/
  EOH
end
