Using the oracle_prereqs module apply the necessary setup:

    $ puppet apply --verbose --modulepath=./modules manifests/oracle.pp

Reboot the VM to bring in the kernel changes.

Then switch to the Oracle user and then run the Oracle installer:

    $ ./runInstaller -silent -responseFile /home/oracle/db_install.rsp

When it has completed, run the root scripts:

    /u01/app/oracle/product/11.2.0.4/dbhome_1/root.sh
    /u01/app/oraInventory/orainstRoot.sh

Then use the oracle_post puppet module:

    $ puppet apply --verbose --modulepath=./modules manifests/oracle_post.pp

This will put the necessary files in place to complete the setup.

Then as Oracle, create the database:

    export ORACLE_HOME=/u01/app/oracle/product/11.2.0.4/dbhome_1
    export PATH=$PATH:/u01/app/oracle/product/11.2.0.4/dbhome_1/bin
	export ORACLE_SID=ora11gr2
	sqlplus / as sysdba
	
	SQL> create spfile from pfile='/u01/app/oracle/product/11.2.0.4/dbhome_1/dbs/initora11gr2.ora';
	SQL> run the db create script

Finally, add an entry to /etc/oratab:

    ora11gr2:/u01/app/oracle/product/11.2.0.4/dbhome_1:Y

That should be Oracle running on the VM. If you reboot the VM, Oracle and the listener should come up at boot time.
