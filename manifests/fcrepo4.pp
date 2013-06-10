class fcrepo4 {
  include epel
  include maven

  package { ['daemonize','git','java-1.7.0-openjdk-devel']:
    ensure  => present,
    require => Class['epel']
  }

  user { 'fcrepo4':
    ensure  => present,
    home    => '/home/fcrepo4',
    system  => true
  }

  file { ['/home/fcrepo4','/var/log/fcrepo4']:
    ensure  => directory,
    owner   => 'fcrepo4',
    require => User['fcrepo4']
  }
  
  exec { 'clone fcrepo4':
    command => '/usr/bin/git clone https://github.com/futures/fcrepo4.git',
    creates => '/usr/local/fcrepo4',
    cwd     => '/usr/local',
    require => Package['git']
  }
  
  file { '/usr/local/fcrepo4':
    ensure  => directory,
    owner   => 'fcrepo4',
    recurse => true,
    require => [User['fcrepo4'], Exec['clone fcrepo4']]
  }
  
  exec { 'build fcrepo4':
    command => '/usr/bin/mvn install',
    creates => '/usr/local/fcrepo4/fcrepo-webapp/target/fcrepo-webapp-4.0-SNAPSHOT.war',
    cwd     => '/usr/local/fcrepo4',
    user    => 'fcrepo4',
    require => [Class['maven'], File['/usr/local/fcrepo4']],
    timeout => 0
  }
  
  file { '/etc/init.d/fcrepo4':
    ensure  => present,
    mode    => 0775,
    require => Package['daemonize'],
    source  => 'puppet:///local/fcrepo4-init.sh'
  }

  service { 'fcrepo4':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => [Exec['build fcrepo4'],File['/etc/init.d/fcrepo4']]
  }
}

include fcrepo4