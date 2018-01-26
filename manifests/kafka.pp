node /^standalone.*/ {
  # These variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  # $kafka_version  = '3.0.0'
  # $kafka_secure   = true

  if $kafka_secure == 'true' {
    $secure = true
  } else {
    $secure = false
  }

  class{ 'cdh::hosts':
    entries => {
      'standalone' => '192.168.33.6'
    }
                          } ->
  class{ 'cdh51java':     } ->
  class{ 'cdh51repo':
        cdh_version => '5.13.0'
  }                         ->
  class{ 'kerberos':      } ->
  class{ 'cdh::zookeeper':
    secure => $secure,
  } ->
  class{ 'cdh_kafka':
    kafka_version   => $kafka_version,
    enable_kerberos => $secure
  }

}