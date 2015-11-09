# == Class: roundcube
#
# This class is the entry point into installing and configuring
# a roundcube instance.
#
# === Parameters
# 
# === Authors
# 
# Ryan Finnin Day <rday@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Ryan Finnin Day
#

class roundcube(
  String $db_provider         = $roundcube::params::db_provider,
  String $db_user             = $roundcube::params::db_user,
  String $db_pass             = $roundcube::params::db_pass,
  String $db_host             = $roundcube::params::db_host,
  String $db_prefix           = $roundcube::params::db_prefix,
  String $debug_level         = $roundcube::params::debug_level,
  String $imap_url            = $roundcube::params::imap_url,
  String $imap_port           = $roundcube::params::imap_port,
  String $smtp_host           = $roundcube::params::smtp_host,
  String $smtp_port           = $roundcube::params::smtp_port,
  String $smtp_user           = $roundcube::params::smtp_user,
  String $smtp_pass           = $roundcube::params::smtp_pass,
  String $support_url         = $roundcube::params::support_url,
  Boolean $auto_create_user   = $roundcube::params::auto_create_user,
  String $timezone            = $roundcube::params::timezone,
  String $des_key             = $roundcube::params::des_key,
  Boolean $verify_peer        = $roundcube::params::verify_peer,
  Boolean $verify_peer_name   = $roundcube::params::verify_peer_name,
  ) inherits roundcube::params {

  include ::roundcube::packages
  include ::roundcube::service

  file { '/var/lib/roundcubemail':
    ensure => directory,
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755',
    require => [
      Package['roundcubemail'],
      Package['httpd'],
    ],
  }

  file { '/var/log/roundcubemail':
    ensure => directory,
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755',
    require => [
      Package['roundcubemail'],
      Package['httpd'],
    ],
  }

  file { '/etc/roundcubemail/config.inc.php':
    ensure => file,
    owner  => 'root',
    group  => 'apache',
    mode   => '0640',
    content => template('roundcube/config.inc.php.erb'),
    require => Package['roundcubemail'],
    notify => Service['httpd'],
  }

  file { '/etc/httpd/conf.d/roundcubemail.conf':
    ensure => file,
    owner  => 'root',
    group  => 'apache',
    mode   => '0644',
    content => template('roundcube/roundcubemail.conf.erb'),
    require => [
      Package['roundcubemail'],
      Package['httpd'],
    ],
    notify => Service['httpd'],
  }

  file { '/etc/php.d/50-timezone.ini':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    content => template('roundcube/50-timezone.ini.erb'),
    require => [
      Package['httpd'],
    ],
    notify => Service['httpd'],
  }

  file { 'server_cert':
    ensure => file,
    path   => "/etc/ssl/certs/${cube[server_cert]}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/roundcube/${cube[server_cert]}",
  }

  selboolean { 'httpd_can_network_connect':
      value      => on,
      persistent => true,
  }

}
