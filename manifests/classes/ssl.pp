class passenger::ssl {
  package { [ "mod_ssl" , "mod_authz_ldap" ]:	
    ensure => present, require => Package["webserver"], 
    notify => Service["$webserver"]
  } 
  file {
    "/etc/$webserver/conf.d/ssl.conf":
      content => template('passenger/ssl.conf.erb'),
      mode => 0644, owner => root, group => root,
      notify => Exec["reload-apache2"];
    ["/var/cache/mod_ssl", "/var/cache/mod_ssl/scache"]:
      ensure => directory,
      owner => apache, group => root, mode => 0750,
      notify => Service["$webserver"];
  }
}
