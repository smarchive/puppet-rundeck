# == Class: rundeck
#
# A basic module to manage Rundeck, an open-source process
# automation and command orchestration tool
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
class rundeck(
  $version         = 'present',
  $config_source   = 'puppet:///modules/rundeck/default_config',
  $enable          = true,
  $start           = true,
) {

  class{'rundeck::install': } ->
  class{'rundeck::config': } ~>
  class{'rundeck::service': } ->
  Class['rundeck']
}
