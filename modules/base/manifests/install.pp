class base::install {
  package { [net-tools, wget, libcurl-devel, openssl-devel, zlib-devel]:
    ensure => present,
  }

  exec { 'yum Group Install':
    unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Development tools"',
  }

  # SELinux
  #
  # Firewall 

}
