This specfile will create a maven rpm from the binary Maven tar.gz file available on the Apache website.

This version uses the maven build apache-maven-3.2.5-bin.tar.gz.

When the RPM is built, it will install maven in /usr/maven/apache-maven-3.2.5 with a symlink in /usr/local/bin/mvn -> /usr/maven/apache-maven-3.2.5/bin/mvn

