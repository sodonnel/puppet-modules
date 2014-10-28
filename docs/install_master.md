# Puppet Standalone

## Install Puppet Labs Repo

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

## Install Puppet

    yum install puppet

Now the machine is puppet enabled, and hence you can configure the rest of it with puppet.

This will also bring down Ruby and a few other things.


Now you can install puppet modules with the following syntax:

puppet apply --modulepath ./modules manifests/node.pp --ordering manifest

# Register Node

Assuming you have a master running, each node must register with the master:

    puppet agent --verbose --no-daemonize

On the first run, this will generate a certificate and sent it to the master.

Assuming the master is not setup to autosign every certificate, then you must sign the certificate onthe master to allow the node to join.

List the nodes with pending certificates:

    puppet cert list

    "puppetnode" (SHA256) 07:05:62:95:67:3E:3D:48:46:B5:F0:F2:6A:51:03:7B:FE:7A:CA:C2:EF:9D:75:3F:3D:62:24:2C:4B:F8:E1:2E

Then sign the certificates:

    puppet cert --sign puppetnode


Now the node is ready to receive manifests.

# Configure Node To Receive Manifests




# Puppet Master Install (Centos 7)

Virtual box - host-only for machines to communicate with each other!

After minimal install:

    yum install net-tools
    yum groupinstall "Development Tools"
    yum install libcurl-devel openssl-devel zlib-devel

Disable selinux by editing /etc/selinx/config and setting to diabled.

Disable the firewall:

    systemctl disable firewalld

Reboot.


# Install Puppet Labs REPO

Centos 7

    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

Centos 6

    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

# Install Puppet Server

    yum install puppet-server

# Change the Config

The main puppet config file is at /etc/puppet/puppet.conf. In this file, you want to define the server names for your puppet master, which by default just 'puppet'.

In the main section, add the following for all the DNS alises you want to use, for example:

    dns_alt_names = puppet,puppet.example.com,puppetmaster01,puppetmaster01.example.com

    This is not necessary if the only DNS name is puppet.

Now start Puppet to generate the CA certificate and key files:

    puppet master --verbose --no-daemonize

Once it says Notice: `Starting Puppet master version <VERSION>`, type ctrl-C to kill the process.

# Install A Better Webserver

Puppet comes with a built in webserver, but this is not good for production loads. Ideally, configure Apache with Passenger:

    yum install httpd httpd-devel mod_ssl ruby-devel rubygems gcc
    gem install rack passenger
    passenger-install-apache2-module

Then make the directories and files required to serve the application out of Passenger:

    mkdir -p /usr/share/puppet/rack/puppetmasterd
    mkdir /usr/share/puppet/rack/puppetmasterd/public /usr/share/puppet/rack/puppetmasterd/tmp
    cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd/
    chown puppet:puppet /usr/share/puppet/rack/puppetmasterd/config.ru

!!! Permissions on these files above?? The Puppet user needs to be able to write them and read them apparently.

Finally, create the following in the files puppetmaster.conf in /etc/httpd/conf/conf.d to configure Apache. Note that some paths will need to be tweaked depending on the certificate names and the version of Passenger that got installed.

    # You'll need to adjust the paths in the Passenger config depending on which OS
    # you're using, as well as the installed version of Passenger.
    LoadModule passenger_module /usr/local/share/gems/gems/passenger-4.0.53/buildout/apache2/mod_passenger.so
    <IfModule mod_passenger.c>
       PassengerRoot /usr/local/share/gems/gems/passenger-4.0.53
       PassengerDefaultRuby /usr/bin/ruby
     </IfModule>

     # And the passenger performance tuning settings:
     # Set this to about 1.5 times the number of CPU cores in your master:
     PassengerMaxPoolSize 4
     # Recycle master processes after they service 1000 requests
     PassengerMaxRequests 1000
     # Stop processes if they sit idle for 10 minutes
     PassengerPoolIdleTime 600

    Listen 8140
    <VirtualHost *:8140>
        # Make Apache hand off HTTP requests to Puppet earlier, at the cost of
        # interfering with mod_proxy, mod_rewrite, etc. See note below.
        PassengerHighPerformance On

    SSLEngine On

    # Only allow high security cryptography. Alter if needed for compatibility.
    SSLProtocol ALL -SSLv2 -SSLv3
    SSLCipherSuite EDH+CAMELLIA:EDH+aRSA:EECDH+aRSA+AESGCM:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:EECDH:+CAMELLIA256:+AES256:+CAMELLIA128:+AES128:+SSLv3:!aNULL:!eNULL:!LOW:!3DES:!MD5:!EXP:!PSK:!DSS:!RC4:!SEED:!IDEA:!ECDSA:kEDH:CAMELLIA256-SHA:AES256-SHA:CAMELLIA128-SHA:AES128-SHA
    SSLHonorCipherOrder     on

    SSLCertificateFile      /var/lib/puppet/ssl/certs/puppet_master_cert.pem
    SSLCertificateKeyFile   /var/lib/puppet/ssl/private_keys/puppet_master_cert.pem
    SSLCertificateChainFile /var/lib/puppet/ssl/ca/ca_crt.pem
    SSLCACertificateFile    /var/lib/puppet/ssl/ca/ca_crt.pem
    SSLCARevocationFile     /var/lib/puppet/ssl/ca/ca_crl.pem
    SSLCARevocationCheck 	chain
    SSLVerifyClient         optional
    SSLVerifyDepth          1
    SSLOptions              +StdEnvVars +ExportCertData

    # Apache 2.4 introduces the SSLCARevocationCheck directive and sets it to none
	# which effectively disables CRL checking. If you are using Apache 2.4+ you must
    # specify 'SSLCARevocationCheck chain' to actually use the CRL.

    # These request headers are used to pass the client certificate
    # authentication information on to the puppet master process
    RequestHeader set X-SSL-Subject %{SSL_CLIENT_S_DN}e
    RequestHeader set X-Client-DN %{SSL_CLIENT_S_DN}e
    RequestHeader set X-Client-Verify %{SSL_CLIENT_VERIFY}e

    DocumentRoot /usr/share/puppet/rack/puppetmasterd/public

    <Directory /usr/share/puppet/rack/puppetmasterd/>
      Options None
      AllowOverride None
      # Apply the right behavior depending on Apache version.
      <IfVersion < 2.4>
        Order allow,deny
        Allow from all
      </IfVersion>
      <IfVersion >= 2.4>
        Require all granted
      </IfVersion>
    </Directory>

    ErrorLog /var/log/httpd/puppet-server.example.com_ssl_error.log
    CustomLog /var/log/httpd/puppet-server.example.com_ssl_access.log combined
</VirtualHost>


Finally, disable the puppetmaster standalone daemon starting on system boot, and enable Apache:

    systemctl disable puppetmaster
    systemctl enable httpd
    

