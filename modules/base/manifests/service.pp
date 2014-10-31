class base::service {

  service { "firewalld":
    name        => 'firewalld',
    ensure      => stopped,
    hasrestart  => true,
    hasstatus   => true,
    enable      => false,
  }

  cron { puppet-agent:
    command => "/usr/bin/puppet agent --onetime --no-daemonize --splay",
    user    => root,
    minute  => 30,
    ensure  => present,
  }
  
}
