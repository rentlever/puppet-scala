class scala {

  require wget

  $version = '2.11.4'

  file { '/usr/local':
    ensure => directory,
  }

  file { "/tmp/scala-${version}.tgz":
    ensure => present,
    require => Exec['Fetch scala'],
  }

  exec { 'Fetch scala':
    cwd => '/tmp',
    command => "wget http://www.scala-lang.org/files/archive/scala-${version}.tgz",
    creates => "/tmp/scala-${version}.tgz",
    path    => ['/opt/boxen/homebrew/bin'],
    require => File['/usr/local'];
  }

  exec { 'Extract scala':
    cwd     => '/usr/local',
    command => "tar xvf /tmp/scala-${version}.tgz",
    creates => "/usr/local/scala-${version}",
    path    => ['/usr/bin'],
    require => Exec['Fetch scala'];
  }

  file { "/usr/local/scala-${version}":
    require => Exec['Extract scala'];
  }

  file { '/usr/local/scala':
    ensure  => link,
    target  => "/usr/local/scala-${version}",
    require => File["/usr/local/scala-${version}"];
  }
  
  file { '/opt/boxen/bin/scala': 
    ensure => link,
    target  => '/usr/local/scala/bin/scala',
    require => File['/usr/local/scala'];
  }

}
