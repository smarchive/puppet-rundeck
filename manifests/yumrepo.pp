class rundeck::yumrepo ($enabled=1){
  yumrepo {
    'rundeck':
      baseurl  => 'http://dl.bintray.com/rundeck/rundeck-rpm',
      gpgcheck => 0,
      enabled  => $enabled,
  }

  Yumrepo['rundeck'] -> Package['rundeck']

}
