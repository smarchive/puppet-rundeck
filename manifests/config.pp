# == Class: rundeck::config
#
# Create configuration files for Rundeck.
#
class rundeck::config {

  $datasource     = $rundeck::datasource
  $use_ssl        = $rundeck::use_ssl
  $keypass        = $rundeck::keypass
  $storepass      = $rundeck::storepass
  $realm_users    = $rundeck::realm_users
  $server_port    = $rundeck::server_port
  $temp_dir       = $rundeck::temp_dir

  if $use_ssl {
    $protocol = 'https'
  }
  else {
    $protocol = 'http'
  }

  $server_url = "${protocol}://${rundeck::server_fqdn}:${server_port}"

  file { '/etc/rundeck/rundeck-config.properties':
    ensure  => present,
    owner   => 'rundeck',
    group   => 'rundeck',
    mode    => '0640',
    content => template('rundeck/rundeck-config.properties.erb')
  }

  file { '/etc/rundeck/ssl/ssl.properties':
    ensure  => present,
    owner   => 'rundeck',
    group   => 'rundeck',
    mode    => '0640',
    content => template('rundeck/ssl.properties.erb')
  }

  file { '/etc/rundeck/profile':
    ensure  => present,
    owner   => 'rundeck',
    group   => 'rundeck',
    mode    => '0640',
    content => template('rundeck/profile.erb')
  }

  file { '/etc/rundeck/realm.properties':
    ensure  => present,
    owner   => 'rundeck',
    group   => 'rundeck',
    mode    => '0640',
    content => template('rundeck/realm.properties.erb')
  }


}
