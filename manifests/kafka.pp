node /^standalone.*/ {
  # These variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  # $kafka_version  = '3.0.0'

  class{ 'cdh::hosts':
    entries => {
      'standalone' => '192.168.33.6'
    }
                          } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh51repo':
        cdh_version => '5.13.0'
  }                         ->
  class{ 'cdh::zookeeper':} ->
  class{ 'cdh_kafka':
        kafka_version => $kafka_version
  }

}