Summary: Maven
Name: apache-maven
Version: 3.2.5
Release: 1
Group: Software Development
Distribution: Apache Maven packaged as an RPM
Vendor: Apache
Packager: Stephen ODOnnell
License: GPL
# Skip autogenerating RPM dependencies
AutoReqProv: no

%description
Java JDK packaged as an RPM

%prep
rm -rf $RPM_BUILD_DIR/apache-maven-%{version}
rm -rf $RPM_BUILD_ROOT/*
tar zxf $RPM_SOURCE_DIR/apache-maven-%{version}-bin.tar.gz -C $RPM_BUILD_DIR

%build

%install
mkdir -p $RPM_BUILD_ROOT/usr/maven
cp -r $RPM_BUILD_DIR/apache-maven-%{version} $RPM_BUILD_ROOT/usr/maven/

%files
/usr/maven/apache-maven-%{version}

%post
ln -s /usr/maven/apache-maven-%{version}/bin/mvn /usr/local/bin/mvn
