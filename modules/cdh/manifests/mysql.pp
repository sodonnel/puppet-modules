class cdh::mysql(
  $root_password = 'root123'  
) {

  class { '::mysql::server':
    root_password    => $root_password,
    service_enabled  => true,
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }

  package { ['mysql-connector-java']:
    ensure => present,
  }

}