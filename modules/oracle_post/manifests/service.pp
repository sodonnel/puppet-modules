class oracle_post::service {

  file { '/etc/rc.d/init.d/dbora':
    ensure => 'present',
    source => 'puppet:///modules/oracle_post/dbora',
    mode   => '750',
    owner  => 'root',
  }

  ->

  service { 'dbora':
    enable => true,
    hasstatus => false,
    hasrestart => false,
  }


}