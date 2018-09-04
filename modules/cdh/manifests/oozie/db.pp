class cdh::oozie::db
{

  require cdh::mysql

  mysql::db { 'oozie':
    user     => $cdh::oozie::dbuser,
    password => $cdh::oozie::dbpass,
    grant    => ['ALL']
  }

}