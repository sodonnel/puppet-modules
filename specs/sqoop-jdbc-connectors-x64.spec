Summary: Sqoop JDBC connectors
Name: sqoopjdbc
Version: 1.0.0
Release: 1
Group: Software Development
Distribution: Sqoop JDBC connectors for Hadoop
Vendor: NA
Packager: Stephen ODOnnell
License: GPL
# Skip autogenerating RPM dependencies
AutoReqProv: no

%description
Mysql and Oracle JDBC connectors for Sqoop

%prep

%build

%install
mkdir -p $RPM_BUILD_ROOT/var/lib/sqoop
cp $RPM_SOURCE_DIR/*.jar $RPM_BUILD_ROOT/var/lib/sqoop

%files
%attr(755, sqoop, sqoop) /var/lib/sqoop
%attr(755, sqoop, sqoop) /var/lib/sqoop/*.jar

%post
