class cdh::sentry(
  $install         = true,
  $dbhost          = 'localhost',
  $dbuser          = 'sentry',
  $dbpass          = 'sentry',
  $use_embedded_db = false,
  $enabled         = false
){

  if ($install) {
    class {'cdh::sentry::install':}     ->
    class {'cdh::sentry::db':}          ->
    class {'cdh::sentry::config':
      dbhost          => $dbhost,
      dbuser          => $dbuser,
      dbpass          => $dbpass,
      use_embedded_db => $use_embedded_db,
    }                                  ->
    class {'cdh::sentry::service':
      enabled => $enabled
    }
  }

}