class oracle_prereqs::limits {
 
  file_line { 'oracle_kernel_limits':
     path => '/etc/sysctl.conf',
     line => 
'kernel.sem = 250 32000 100 128
fs.file-max = 6815744
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default=262144
net.core.wmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_max=1048576
fs.aio-max-nr=1048576',
}


  file_line { 'oracle_pam_limits':
    path => '/etc/security/limits.conf',
    line => 
'oracle              soft    nproc   2047
oracle              hard    nproc   16384
oracle              soft    nofile  1024
oracle              hard    nofile  65536',
  }

  file_line { 'oracle_pam_login':
    path => '/etc/pam.d/login',
    line => 'session    required     pam_limits.so',
  }
}