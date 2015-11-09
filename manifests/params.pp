class roundcube::params {

  case $::osfamily {
    'RedHat': {
      $package_name = 'roundcubemail'
    }
    default: {
      $package_name = 'roundcubemail'
    }
  }
}
