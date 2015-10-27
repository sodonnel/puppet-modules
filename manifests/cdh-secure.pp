node /^standalone.*/ {
  $hive_version = '1.1.0'
  $cdh_version  = '5.4.5'

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
    secure   => true,
                          } 
}