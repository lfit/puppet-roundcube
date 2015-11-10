class roundcube::packages {
  package { 'epel-release':
    ensure => 'installed',
  }
  package { 'roundcubemail':
    name   => "${::roundcube::params::package_name}",
    ensure => 'installed',
    require => Package['epel-release'],
  }
  package { 'httpd':
    ensure => 'installed',
  }
  package { 'php-mysql':
    ensure => 'installed',
  }
  package { 'php-mcrypt':
    ensure => 'installed',
  }
}
