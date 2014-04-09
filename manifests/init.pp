# == Class: rundeck
#
# A module to install and configure Rundeck.
#
# === Parameters
# [*version*]
#   The version of the Rundeck package to install
#
# [*enable*]
#   Should the service be enabled during boot time?
#
# [*start*]
#   Should the service be started by Puppet
#
# [*server_fqdn*]
#   The fully qualified domain name of the Rundeck server
#
# [*datasource*]
#   A hash used to configure the database connection. Should contain the following entries:
#     driver : the JDCB driver class name.
#     username : the JDBC connection username
#     password : the JDBC connection driver
#     url : the JDBC connection URL
#     dialect : the JDBC dialect (optional)
#
# [*use_ssl*]
#   Should SSL be used?
#
# [*keypass*]
#   The SSL key password
#
# [*storepass*]
#   The keystore password
#
# [*keystore_org_unit*]
#   The keystore organizational unit
#
# [*keystore_organization*]
#   The keystore organization
# [*keystore_city*]
#   The keystore city/locality
#
# [*keystore_state*]
#   The keystore state/province
#
# [*keystore_country*]
#   The two-letter keystore country
#
# [*realm_users*]
#   An array of realm users to configure. It should contain a list of hashes with the following entries:
#     name     : the user name
#     password : the user password
#     roles    : a comma-separated list of roles
class rundeck(
  $version               = 'present',
  $enable                = true,
  $start                 = true,
  $temp_dir              = '/tmp/rundeck',
  $server_fqdn           = 'localhost',
  $server_port           = '4440',
  $datasource            = undef,
  $use_ssl               = false,
  $keypass               = 'adminadmin',
  $storepass             = 'adminadmin',
  $keystore_org_unit     = undef,
  $keystore_organization = undef,
  $keystore_city         = undef,
  $keystore_state        = undef,
  $keystore_country      = undef,
  $realm_users           = [ { 'name' => 'admin', 'password' => 'admin', 'roles' => 'admin,architect,deploy,build' } ]
  ) {

  if(!is_array($config_source) and !is_string($config_source)) {
    fail('config_source must be either an array or a string')
  }

  validate_bool($enable)
  validate_bool($start)
  validate_bool($use_ssl)

  class{'rundeck::install': }

  if $use_ssl {
    # Create the keystore with a self-signed cert.
    class{'rundeck::keystore':
        require => Class['rundeck::install'],
        notify  => Class['rundeck::service'],
    }
  }

  class{'rundeck::config':
    require => Class['rundeck::install'],
  } ~>
  class{'rundeck::service': } ->
  Class['rundeck']
}
