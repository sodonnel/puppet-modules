class base::service {

  if $operatingsystemrelease =~ /^7.*/ {
    $firewallservice = 'firewalld'
  }
  else {
    $firewallservice = 'iptables'
  }
    
  
  service { "firewalld":
    name        => $firewallservice,
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
