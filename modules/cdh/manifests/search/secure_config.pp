class cdh::search::secure_config (
  $namenodehostname        = namenode,
  $zookeeper_ensemble      = 'localhost:2181/solr',
  $secure                  = false,
) {

  if ($secure == true) {

    cdh::kinit { 'searchConfig':  
    }

    ->

    exec {'solr-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/solr/conf/solr.keytab solr/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/solr/conf/solr.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/solr/conf/solr.keytab':
      owner => 'solr',
      mode  => '600',
    }

    # SOLR is sharing the hdfs HTTP keytab

    ->

    file { "/etc/solr/conf/jaas.conf":
      ensure  => present,
      content => template("cdh/solr_jaas.conf.erb"),
      owner   => "root",
      group   => "root",
    }

    ->

    file { "/etc/solr/conf/sentry-site.xml":
      ensure  => present,
      content => template("cdh/solr_sentry-site.xml.erb"),
      owner   => "root",
      group   => "root",
    }

  }

}