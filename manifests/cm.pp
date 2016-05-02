node /^cm.*/ {
  # These two variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  # $cm_version  = '5.5.2'
  # $cdh_secure = 'true'

  class{ 'cloudera_manager_repo':
    cm_version => $cm_version    
                          } ->
  class{ 'cdh51java':     } ->
  class{ 'kerberos':
    kdc_hostname => 'cm'
  }                         ->
  class{ 'cloudera_manager': }
}


node /^node.*/ {
  # These two variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  # $cm_version  = '5.5.2'
  # $cdh_secure = 'true'

  class{ 'cdh51java':     }
  class{ 'kerberos::client':
    kdc_hostname => 'cm'
  }

}
