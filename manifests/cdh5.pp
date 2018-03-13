node /^master.*/ {

   $cdh_version  = '5.14.0'
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
    quorm  => ['master', 'dn1'],
    instance_id => '1',
  }

  ->

  ### !! Remember MYSQL is currently bound up in this package :(
  class{ 'cdh::metastore':
    namenodehostname        => 'master',
    metastorehostname       => 'master',
    mysqlusername           => 'hive',
    mysqlpassword           => 'hive123',
    mysqlpasswordhash       => '*FB73BCDD6050E0F3F73E0262950F4D9E0092769C', # hive123
  }

  ->

  class{ 'cdh::oozie':
    secure  => false,
    dbhost  => 'localhost',
    dbuser  => 'oozieuser',
    dbpass  => 'secret',
    enabled => false,
    namenodehostname => 'master',
  }

  ->

  class{ 'cdh::hbase':
    namenodehostname        => 'master',
    zookeeper_ensemble      => 'master:2181,dn1:2181',
    masterenabled           =>  true,
    regionenabled           => false,
    thriftenabled           => true,
    secure                  => false
  }
  
}


node /^dn.*/ {

  # $cdh_version  = '5.5.1'
  # $cdh_secure = 'false'


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


 if $hostname == 'dn1' {
    class{  'cdh::zookeeper':
      secure => false,
      quorm  => ['master', 'dn1'],
      instance_id => '2',
    }
 }

 if $hostname == 'dn2' {
    class{  'cdh::zookeeper':
      secure => false,
      quorm  => ['master', 'dn1'],
      instance_id => '3',
    }
 }


  class{ 'cdh::hbase':
    namenodehostname        => 'master',
    zookeeper_ensemble      => 'master:2181,dn1:2181',
    masterenabled           =>  false,
    regionenabled           => true,
    thriftenabled           => true,
    secure                  => false
  }

  if (($hostname == 'dn1') or ($hostname == 'dn2')) {
    Class['cdh::datanode']  -> Class['cdh::zookeeper'] -> Class['cdh::hbase']
  } else {
    Class['cdh::datanode']  -> Class['cdh::hbase']
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
  # These three variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
#   $cdh_version  = '5.14.0'
#   $cdh_secure = 'true'
#   $cdh_encryption = 'true'

#   $install_hue = 'true'
#   $install_oozie = 'true'
#   $install_search = 'true'
  
  if $cdh_secure == 'true' {
    require 'kerberos'
    $hadoop_security = true
  } else {
    $hadoop_security = false
  }
  if $cdh_encryption == 'true' {
    $hadoop_encryption = true
  } else {
    $hadoop_encryption = false
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
  class{ 'rootca':        } ->
  class{ 'cdh::singlenode':
    hostname   => 'standalone',
    secure     => $hadoop_security,
    encryption => $hadoop_encryption,
    install_hue    => $install_hue,
    install_oozie  => $install_oozie,
    install_search => $install_search
                          } 
}
