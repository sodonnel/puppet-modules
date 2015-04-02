Summary: Java JDK
Name: javajdk
Version: 1.7.0
Release: 55
Group: Software Development
Distribution: Java 7 for RedHat Linux
Vendor: Oracle
Packager: Stephen ODOnnell
License: GPL
# Skip autogenerating RPM dependencies
AutoReqProv: no

%description
Java JDK packaged as an RPM

%prep
rm -rf $RPM_BUILD_DIR/jdk%{version}_%{release}
rm -rf $RPM_BUILD_ROOT/*
tar zxf $RPM_SOURCE_DIR/jdk-7u55-linux-x64.tar.gz -C $RPM_BUILD_DIR

%build

%install
mkdir -p $RPM_BUILD_ROOT/usr/java
cp -r $RPM_BUILD_DIR/jdk%{version}_%{release} $RPM_BUILD_ROOT/usr/java/

%files
/usr/java/jdk%{version}_%{release}

%post
ln -s /usr/java/jdk%{version}_%{release} /usr/java/default
