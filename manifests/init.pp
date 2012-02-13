class passenger {

  include passenger::packages
  #  include passenger::setup

  #Class['passenger::packages'] -> Class['passenger::setup']


  Exec { path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin', }


  $modulename = 'unifiedpost-passenger'
  $moduleversion = '0.1'

}
