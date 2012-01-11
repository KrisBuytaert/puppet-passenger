class passenger::packages {
  package {
    "rubygem-passenger": 
      ensure => "$passenger::version",
      name => passenger,
      provider => gem,
      require => $::operatingsystem ? {
        default => Package["$apache::apache"],
        archlinux => Package["apache"],
        debian => Package["apache"],
      },
      before => Service["$apache::apache"];

    'curl-devel':
      ensure => installed,
      name => $::operatingsystem ? {
        archlinux => 'curl',
        centos => 'libcurl-devel',
        debian => 'libcurl4-openssl-dev',
      };

    'gcc':;
    'gcc-c++':;
  }
}
