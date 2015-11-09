class roundcube::packages {
  package { 'roundcubemail':
    name   => "${::roundcube::params::package_name}",
    ensure => 'installed',
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
