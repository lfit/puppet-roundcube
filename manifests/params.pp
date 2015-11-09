# == Class: roundcube::params
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# Ryan Finnin Day <rday@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Ryan Finnin Day

class roundcube::params {

  $db_provider      = 'mysql'
  $db_user          = 'lfroundcube'
  $db_pass          = 'password'
  $db_host          = 'db.finninday.net'
  $db_dbname        = 'lfmail'
  $db_prefix        = 'rc_'
  $debug_level      = '5'
  $imap_url         = 'ssl://mail.finninday.net'
  $imap_port        = '993'
  $smtp_host        = 'mail.finninday.net'
  $smtp_port        = '587'
  $smtp_user        = ''
  $smtp_pass        = ''
  $support_url      = 'http://finninday.net/wiki/index.php/Roundcube'
  $auto_create_user = true
  $server_cert      = 'newcert.pem'
  $timezone         = 'America/Los_Angeles'
  $des_key          = 'OabdapIcujHasHadfankEsof'
  $verify_peer      = false
  $verify_peer_name = false

  case $::osfamily {
    'RedHat': {
      $package_name = 'roundcubemail'
    }
    default: {
      $package_name = 'roundcubemail'
    }
  }
}
