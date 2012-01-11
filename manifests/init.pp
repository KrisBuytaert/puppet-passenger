import 'classes/*'

class passenger (
	$version = '3.0.8'
) {
    class {
		'::ruby':;
		'passenger::packages':
			require => Class['::ruby'];
		'passenger::config':
			require => Class['passenger::packages'];
	}

    Exec{path=>'/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin'}
}
