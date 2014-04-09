# == Class: rundeck::install
#
# Install the Rundeck package.
#
class rundeck::install {
  $temp_dir = $rundeck::temp_dir

  package { 'rundeck':
    ensure => $rundeck::version,
  } ->
  file { $temp_dir:
    ensure => directory,
    owner  => 'rundeck',
    group  => 'rundeck',
    mode   => '0750',
  }
}
