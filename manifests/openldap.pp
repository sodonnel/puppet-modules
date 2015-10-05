node "basic" {

  class{ 'openldap':
    basedn => 'appsintheopen'    
  } 

}
