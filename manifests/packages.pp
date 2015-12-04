class roundcube::packages {

  include ::epel

  ensure_resource('package', 
    [
      'httpd',
      'php-mysql',
      'php-mcrypt',
      'roundcubemail'
    ],
    {
      'ensure' => 'installed'
    }
  )
}
