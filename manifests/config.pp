# == Class: passenger::config
#
# Description of passenger::config
#
# === Parameters:
#
# === Actions:
#
# === Requires:
#
# === Sample Usage:
#
class passenger::config {
  file {
    'passenger.conf':
       path => $::operatingsystem ? {
           archlinux => '/etc/httpd/conf/extra/passenger.conf',
           centos => "/etc/httpd/conf.d/passenger.conf",
           debian => "/etc/apache2/conf.d/passenger.conf",
       },
       content => template('passenger/passenger.conf.erb'),
       mode => 644,
       owner=> root,
       group => root,
       notify => Service ["$apache::apache"],
  }

  exec {
	'install modules':
		command => $::operatingsystem ? {
			default => "$ruby::bin_dir/passenger-install-apache2-module --auto",
			debian => "$ruby::lib_dir/gems/$ruby::version/gems/passenger-$passenger::version/bin/passenger-install-apache2-module --auto",
		},
		creates => "$ruby::lib_dir/gems/$ruby::version/gems/passenger-$passenger::version/ext/apache2/mod_passenger.so";
  }

  if $::operatingsystem == 'archlinux' {
	exec {
		'include passenger.conf':
			command => 'echo -e "\n# Passenger config\nInclude conf/extra/passenger.conf" >> /etc/httpd/conf/httpd.conf',
			require => File['passenger.conf', 'apache.conf'];
	}
  }
}
