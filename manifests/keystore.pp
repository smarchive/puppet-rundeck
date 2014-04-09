# == Class: rundeck::keystore
#
# Creates the keystore used for SSL communication.
#
class rundeck::keystore {

  $keystore_org_unit     = $rundeck::keystore_org_unit
  $keystore_organization = $rundeck::keystore_organization
  $keystore_city         = $rundeck::keystore_city
  $keystore_state        = $rundeck::keystore_state
  $keystore_country      = $rundeck::keystore_country
  $keypass               = $rundeck::keypass
  $storepass             = $rundeck::storepass
  $server_fqdn           = $rundeck::server_fqdn

  $keytool_input_file = '/etc/rundeck/ssl/keytool.input'
  $keytool_command = "/usr/bin/keytool -keystore /etc/rundeck/ssl/keystore -alias rundeck -genkey -keyalg RSA -keypass ${keypass} -storepass ${storepass} < ${keytool_input_file}"

  file { $keytool_input_file:
    ensure => present,
    content => template('rundeck/keytool.input.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  } ~>
  exec { 'create-keystore':
    command =>  $keytool_command,
    creates => '/etc/rundeck/ssl/keystore',
  } ->
  file { '/etc/rundeck/ssl/truststore':
    source => '/etc/rundeck/ssl/keystore',
    owner   => 'rundeck',
    group   => 'rundeck',
    mode    => '0640',
  }


}