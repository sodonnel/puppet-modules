class cdh::sentry::db
{

  if ($cdh::sentry::use_embedded_db == false) {
     require cdh::mysql

     mysql::db { 'sentry':
      user     => $cdh::sentry::dbuser,
      password => $cdh::sentry::dbpass,
      grant => ['ALL']
    }


  }
}