$hosts_entries = {
  puppet            => '192.168.57.5',
  namenode          => '192.168.57.6',
  datanode          => '192.168.57.7',
  resourcemanager   => '192.168.57.9',
  historyserver     => '192.168.57.9',
  metastore         => '192.168.57.10',
}

node /^master.*/ {

  $cdh_version  = '5.5.1'
  $cdh_secure = 'false'

  class { 'cdh::config':
    includehive             => false,
    includeyarn             => true,
    namenodehostname        => 'master',
    resourcemanagerhostname => 'master',
    metastorehostname       => 'master',
    mysqlusername           => 'hive',
    mysqlpassword           => 'hive123',
    yarnavailablememory     => 3072,
    yarnavailablecores      => 2,
    secure                  => false,
  } 

  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->

  class{ 'cdh::namenode':
    namenodehostname => 'master'
  }
  
  ->
   
  class{ cdh::resourcemanager:
    namenodehostname         => 'master',
    resourcemanagerhostname  =>  'master'
  }

  ->

  class{  'cdh::zookeeper':
    secure => false,
    quorm  => ['master'],
  }

  ->

  class{ 'cdh::metastore':
    namenodehostname        => 'master',
    metastorehostname       => 'master',
    mysqlusername           => 'hive',
    mysqlpassword           => 'hive123',
    mysqlpasswordhash       => '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C', # hive123
  }
}


node /^dn.*/ {

  $cdh_version  = '5.5.1'
  $cdh_secure = 'false'


  class { 'cdh::config':
    includehive             => true,
    includeyarn             => true,
    namenodehostname        => 'master',
    resourcemanagerhostname => 'master',
    metastorehostname       => 'master',
    mysqlusername           => 'dummy',
    mysqlpassword           => 'dummy',
    yarnavailablememory     => 3072,
    yarnavailablecores      => 2,
    secure                  => false,
  }

  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::datanode':
    hostentries => $hosts_entries
  }

}


node /^client.*/ {
  class{ 'localyumrepo':  } ->
  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::client':
    hostentries => $hosts_entries
  }
}


node /^basic/ {
  class{ 'cdh51repo':
    cdh_version => $cdh_version    
                          } ->


  class{ 'cdh::zookeeper::install': } ->
  class{ 'cdh::zookeeper::config':
      quorm => ['basic', 'basic2', 'basic3']
  } ->
  class{ 'cdh::zookeeper::service':
  }
}

node /^standalone.*/ {
  # These two variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  $cdh_version  = '5.5.1'
  $cdh_secure = 'true'
  if $cdh_secure == 'true' {
    require 'kerberos'
    $hadoop_security = true
  } else {
    $hadoop_security = false
  }

  class{ 'cdh::hosts':
    entries => {
      'standalone' => '192.168.33.6',
      'kerberos.example.com' => '192.168.33.9'
    }
                          } -> 
  class{ 'cdh51repo':
    cdh_version => $cdh_version    
                          } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::local':
    hostname => 'standalone',
    secure   => $hadoop_security,
                          } 
}
