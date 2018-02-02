class cdh::config::hdfs {
  
  $namenodehostname = $::cdh::config::namenodehostname
  $secure           = $::cdh::config::secure
  $encryption       = $::cdh::config::encryption

  if ($encryption) {
    # Need to:
    #  * Create the /opt/cloudera/security directory
    #  * copy the truststore from the root_ca
    #  * run the script in the root ca to generate a cert / keystore for this host
    #  * copy it into place
    # Tricky part is that for 'clusters' the rootca may not be on this host

    file { ["/opt", "/opt/cloudera", "/opt/cloudera/security"]:
      ensure  => directory,
      owner   => "root",
      group   => "root",
      mode    => "755",
    }

    ->

    exec { "generate_host_certificate":
      command => "/root/ca/generate_and_sign_cert.sh ${hostname}",
      path    => ["/usr/bin", "/root/ca"],
      creates => "/root/ca/intermediate/certs/${hostname}.cert.pem",
      user    => 'root',
      cwd     => "/root/ca",
    }

    ->

    file { "/opt/cloudera/security/cdh.truststore":
      ensure => present,
      source => "file:///root/ca/intermediate/certs/ca.truststore",
      owner => "root",
      group => "root",
      mode  => "444",
    }

    ->

    file { "/opt/cloudera/security/cdh.keystore":
      ensure => 'present',
      source => "file:///root/ca/intermediate/private/${hostname}.keystore",
      owner => "root",
      group => "root",
      mode  => "444",
    }

  }

  file { ["/etc/hadoop", "/etc/hadoop/conf"]:
    ensure  => directory,
    owner   => "root",
    group   => "root",
    mode    => "755",
  }

  ->

  file { "/etc/hadoop/conf/hdfs-site.xml":
    ensure  => present,
    content => template("cdh/hdfs-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/core-site.xml":
    ensure  => present,
    content => template("cdh/core-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/ssl-server.xml":
    ensure  => present,
    content => template("cdh/ssl-server.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/ssl-client.xml":
    ensure  => present,
    content => template("cdh/ssl-client.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/default/hadoop-hdfs-datanode":
    ensure  => present,
    content => template("cdh/hadoop-hdfs-datanode.erb"),
    owner   => "root",
    group   => "root",
    mode    => '644',
  }

}
