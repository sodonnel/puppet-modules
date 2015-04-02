To build RPMs on Centos, one way is to use the rpmbuild tool.

First install it:

    $ yum install rpm-build

I generally prepare RPMs as the root user. The first think you do is create the directory skeleton:

    $ mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

Then you prepare the RPM Specfile to build the application exactly as you want it.

Once the specfile is prepared, you build the RPM using the following command:

    $ rpmbuild -ba SPECS/<myspecfile>

This should build the RPM and place the result in the RPMS folder.
