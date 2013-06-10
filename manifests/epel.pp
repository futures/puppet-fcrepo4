class epel {
  exec { 'epel':
    command => "/bin/rpm -ivvh http://mirror.ancl.hawaii.edu/linux/epel/6/i386/epel-release-6-8.noarch.rpm",
    unless  => "/usr/bin/yum repolist -C | /bin/grep epel",
  }
}