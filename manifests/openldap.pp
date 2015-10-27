node /.*kerberos.*/ {

  class{ 'openldap':
    basedn => 'appsintheopen'    
  }

  ->

  class{ 'kerberos':
  }

}
