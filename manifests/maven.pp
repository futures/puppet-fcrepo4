class maven {
  exec { 'maven3':
    command => "/usr/bin/wget -O - http://mirror.metrocast.net/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz | /bin/tar xz --directory=/usr/local",
    creates => "/usr/local/apache-maven-3.0.5",
  }->
  file { '/usr/bin/mvn':
    ensure  => link,
    target  => "/usr/local/apache-maven-3.0.5/bin/mvn",
  }
}