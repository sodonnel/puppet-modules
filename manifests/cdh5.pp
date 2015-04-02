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
  class{ 'cdh::hosts':
    entries => {
      'standalone' => '192.168.57.6'
    }
                          } -> 
#  class{ 'localyumrepo':
#    repourl => 'http://192.168.57.5/yumrepo'
#                          } ->
  class{ 'cdh51repo':    } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh::local':
    hostname => '192.168.57.6'
                          } 
}
