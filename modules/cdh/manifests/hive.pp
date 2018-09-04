class cdh::hive(
  $namenodehostname        = 'standalone',
  $metastorehostname       = 'standalone',
  $mysqlusername           = 'hive',
  $mysqlpassword           = 'hive123',
  $secure                  = false
)
{

  require cdh::mysql

  class{'cdh::hive::install':
  }  ->
  class{'cdh::hive::config':
  }  ->
  class{'cdh::hive::service':
  }
  
}
