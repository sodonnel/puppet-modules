$hosts_entries = {
  puppet            => '192.168.57.5',
  namenode          => '192.168.57.6',
  datanode          => '192.168.57.7',
  resourcemanager   => '192.168.57.9',
  historyserver     => '192.168.57.9',
  metastore         => '192.168.57.10',
}

node /^namenode.*/ {
  class{ 'localyumrepo':  } ->
  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::namenode':
    hostentries => $hosts_entries
  }
}

node /^datanode.*/ {
  class{ 'localyumrepo':  } ->
  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::datanode':
    hostentries => $hosts_entries
  }
}

node /^resourcemanager.*/ {
  class{ 'localyumrepo':  } ->
  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::resourcemanager':
    hostentries => $hosts_entries
  }
}

node /^metastore.*/ {
  class{ 'localyumrepo':  } ->
  class{ 'cdh51repo':     } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::metastore':
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

node /^standalone.*/ {
  # These two variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  # $cdh_version  = '5.3.8'

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
    secure   => false,
                          } 
}
