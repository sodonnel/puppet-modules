class puppetmaster::config {
 
  $hostnames = $puppetmaster::hostnames
      
  file { '/etc/puppet/puppet.conf':
    ensure  => file,
    content => template("puppetmaster/puppet.conf.erb"),
  }

  file { '/usr/share/puppet/rack':
    ensure => 'directory'
  }
  
  file { '/usr/share/puppet/rack/puppetmasterd':
    ensure => 'directory'
  }

  file { '/usr/share/puppet/rack/puppetmasterd/public':
    ensure => 'directory',
    owner  => 'puppet'
  }

  file { '/usr/share/puppet/rack/puppetmasterd/tmp':
    ensure => 'directory',
    owner  => 'puppet'
  }

  file { "/usr/share/puppet/rack/puppetmasterd/config.ru":
      ensure => present,
      source => "/usr/share/puppet/ext/rack/config.ru",
      owner => "puppet",
      group => "puppet",
  }

  file { "/etc/httpd/conf.d/vhost_puppetmaster.conf":
      ensure => present,
      source => "puppet:///modules/puppetmaster/virtual_host.conf",
  }

}
