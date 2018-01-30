class cdh::sentry::service(
  $enabled = false
){

  service { "sentry-store":
    name        => 'sentry-store',
    ensure      => $enabled,
    hasrestart  => true,
    hasstatus   => true,
    enable      => $enabled,
  }

}