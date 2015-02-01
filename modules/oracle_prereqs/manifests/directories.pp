class oracle_prereqs::directories {

  file { "/u01":
    ensure => "directory",
    owner  => root,
  }

  file { "/u01/app":
    ensure => "directory",
    owner  => "oracle",
    group  => "oinstall",
  }


  file { "/u01/app/oracle":
    ensure => "directory",
    owner  => "oracle",
    group  => "oinstall",
  }


  file { "/u01/app/oraInventory":
    ensure => "directory",
    owner  => "oracle",
    group  => "oinstall",
  }


#  oracle_base = /u01/app/oracle
#/u01/app/oracle/product/11.2.0/dbhome_1
#/etc/oraInst.loc inventory location	
#
#inventory_loc=/u01/app/oraInventory 

}
