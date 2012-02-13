# == Class: passenger::params
#
# Description of passenger::params
#
# === Parameters:
#
# === Actions:
#
# === Requires:
#
# === Sample Usage:
#
class passenger::params (
  $packages = undef,
  $configpath = undef,
  $version = undef,
  $template = 'passenger/passenger.conf.erb',
){
  ## Copy paste snippets:
  # template("${module_name}/template.erb")
  # source => "puppet:///modules/${module_name}/file"

  ## Global parameters, module independent.
  $package = $packages ? {
    default => $packages,
    undef   => $::operatingsystem? {
      /(?i:centos|redhat)/ => ['rubygem-passenger',  'mod_passenger'],
      default              => [],
    }
  }




  ## Apache integration
  if defined('::apache') {
    require apache
    notify {'passsenger-detect-apache-module':
      message => "O Hi! I detected that you using a (pluggeable?) apache module ($apache::modulename). Trying to work with it!"
    }
    case $apache::modulename {
      default, undef: {
        fail("The selected module (${apache::modulename}) is not supported by this module.")
      }
      'inuits-puppet-apache': {
        require apache::params
        $conf_file = "${apache::params::confd}/passenger.conf"
        $required_packages = [ $apache::params::package ]
        $notify_services = [ $apache::params::service_name ]
      }
    }

  }
  else {
    $conf_file = $::operatingsystem ? {
      /(?i:archlinux)/     => '/etc/httpd/conf/extra/passenger.conf',
      /(?i:centos|redhat)/ => "/etc/httpd/conf.d/passenger.conf",
      /(?i:debian|ubuntu)/ => "/etc/apache2/conf.d/passenger.conf",
    }
  }

}

