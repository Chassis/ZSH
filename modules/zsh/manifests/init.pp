# A Chassis extension to install and configure ZSH on your server.
class zsh (
	$config,
	$path = '/vagrant/extensions/zsh'
) {
	if ( ! empty( $config[disabled_extensions] ) and 'chassis/zsh' in $config[disabled_extensions] ) {
		$package = absent
		$file    = absent
	} else {
		$package = latest
		$file    = 'present'
	}

	package { "zsh":
		ensure  => $package,
	}

	# Create an empty .zshrc to avoid the setup prompt after logging in.
	file { "/home/vagrant/.zshrc":
		ensure => present
	}

	if ( latest == $package ) {
		exec { 'sudo chsh -s /usr/bin/zsh':
			path    => '/bin:/usr/bin',
			require => Package['zsh']
		}
	} else {
		exec { 'sudo chsh -s /bin/bash':
			path => '/bin:/usr/bin',
		}
	}
}
