class rootca(
  $ca_root = '/root/ca',
)
{

  # Credit to https://jamielinux.com/docs/openssl-certificate-authority/sign-server-and-client-certificates.html
  # for the steps used to create this manifest

  $root = $ca_root

  file { $root:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  ->

  file { ["${root}/certs", "${root}/crl", "${root}/newcerts"]:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  ->

  file { "${root}/private":
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  ->

  file { "${root}/index.txt":
    ensure  => 'present',
    replace => 'no', 
    content => "",
    mode    => '0644',
  }

  ->

  file { "${root}/serial":
    ensure  => 'present',
    replace => 'no', 
    content => "1000\n",
    mode    => '0644',
  }

  ->

  file { "${root}/openssl.cnf":
    ensure  => present,
    content => template("rootca/root_openssl.cnf.erb"),
    owner   => "root",
    group   => "root",
  }

  ->

  exec { 'create_root_ca_cert':
    command => 'openssl req \
               -config openssl.cnf \
               -new \
               -newkey rsa:4096 \
               -days 750 \
               -nodes \
               -x509 \
               -subj "/C=GB/ST=England/L=London/O=hadoop_inc/OU=hadoop_inc_root_ca/CN=Apache Hadoop" \
               -keyout private/ca.key.pem \
               -out certs/ca.cert.pem',
    path    => ['/usr/bin'],
    user    => 'root',
    creates => "${root}/private/ca.key.pem",
    cwd     => $root,
  }

  ->

  file { "${root}/private/ca.key.pem":
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
  }
  
  ->
  
  file { "${root}/certs/ca.cert.pem":
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
  }

  ### Now create the intermediate CA structure

  ->

  file { ["${root}/intermediate", "${root}/intermediate/certs","${root}/intermediate/crl","${root}/intermediate/csr","${root}/intermediate/newcerts"]:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  ->

  file { "${root}/intermediate/private":
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  ->

  file { "${root}/intermediate/index.txt":
    ensure  => 'present',
    replace => 'no', 
    content => "",
    mode    => '0644',
  }

  ->

  file { "${root}/intermediate/serial":
    ensure  => 'present',
    replace => 'no', 
    content => "1000\n",
    mode    => '0644',
  }

  ->

  file { "${root}/intermediate/crlnumber":
    ensure  => 'present',
    replace => 'no', 
    content => "1000\n",
    mode    => '0644',
  }

  ->

  file { "${root}/intermediate/openssl.cnf":
    ensure  => present,
    content => template("rootca/intermediate_openssl.cnf.erb"),
    owner   => "root",
    group   => "root",
  }

  ->

  # Create the Intermediate CA key and a CSR. Note this gets run in the intermediate CA dir
  
  exec { 'create_intermediate_ca_private_key':
    command => 'openssl req \
                  -config intermediate/openssl.cnf \
                  -new \
                  -newkey rsa:4096 \
                  -sha256 \
                  -nodes \
                  -subj "/C=GB/ST=England/L=London/O=hadoop_inc/OU=hadoop_inc_root_ca/CN=Apache Hadoop Intermed" \
                  -keyout intermediate/private/intermediate.key.pem \
                  -out intermediate/csr/intermediate.csr.pem',
    path    => ['/usr/bin'],
    user    => 'root',
    creates => "${root}/intermediate/private/intermediate.key.pem",
    cwd     => "${root}",
  }

  ->

  file { "${root}/intermediate/private/intermediate.key.pem":
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
  }

  # Now sign the intermediate CSR with the root cert to create the intermediate Cert

  ->

  exec { 'create_intermediate_signed_cert':
    command => 'openssl ca \
                  -batch \
                  -config openssl.cnf \
                  -extensions v3_intermediate_ca \
                  -days 3650 \
                  -notext \
                  -md sha256 \
                  -in intermediate/csr/intermediate.csr.pem \
                 -out intermediate/certs/intermediate.cert.pem',
    path    => ['/usr/bin'],
    user    => 'root',
    creates => "${root}/intermediate/certs/intermediate.cert.pem",
    cwd     => "${root}",
  }

  ->

  exec { 'create_ca_certificate_chain_file':
    command => 'cat intermediate/certs/intermediate.cert.pem \
                  certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem',
    path    => ['/usr/bin', '/bin'],
    user    => 'root',
    creates => "${root}/intermediate/certs/ca-chain.cert.pem",
    cwd     => "${root}",
  }

  ->

  exec { 'create_java_truststore_for_ca':
    command => 'keytool -importcert -noprompt -keystore intermediate/certs/ca.truststore -alias CA-cert -storepass vagrant -file certs/ca.cert.pem',
    path    => ['/usr/java/default/bin', '/usr/bin'],
    user    => 'root',
    creates => "${root}/intermediate/certs/ca.truststore",
    cwd     => "${root}",
  }

  ->

  file { "${root}/generate_and_sign_cert.sh":
    ensure  => present,
    content => template("rootca/generate_and_sign_cert.sh.erb"),
    owner   => "root",
    group   => "root",
    mode    => "755",
  }

}