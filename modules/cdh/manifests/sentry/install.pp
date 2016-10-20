class cdh::sentry::install {

  package { ['sentry', 'sentry-store', 'sentry-hdfs-plugin']:
    ensure => present,
  }

}