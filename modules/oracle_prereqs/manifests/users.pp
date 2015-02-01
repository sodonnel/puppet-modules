class oracle_prereqs::users {

  group { "oinstall":
    ensure => "present",
  }
  ->
  group { "dba":
    ensure => "present",
  }
  ->
  group { "oper":
    ensure => "present",
  }
  ->
  group { "asmadmin":
    ensure => "present",
  }
  ->
  user { "oracle":
    ensure => "present",
    gid => 'oinstall',
    groups => ['dba','oper','asmadmin'],
    managehome => true,
  }

}