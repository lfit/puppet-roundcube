class roundcube::service {
  service { 'httpd':
    ensure => running,
    enable => true,
  } 
}
