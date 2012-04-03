group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet.\n"
}

yumrepo {
  'nodejs-stable':
    descr       => "NodeJS Stable",
    enabled     => 1,
    baseurl     => absent,
    mirrorlist  => "http://nodejs.tchol.org/mirrors/nodejs-stable-el\$releasever",
    gpgcheck    => 0;
    
    
  'rpmforge':
    descr       => "RHEL \$releasever - RPMforge.net -dag",
    enabled     => 1,
    baseurl     => "http://apt.sw.be/redhat/el6/en/\$basearch/rpmforge",
    mirrorlist  => "http://apt.sw.be/redhat/el6/en/mirrors-rpmforge",
    gpgcheck    => 0;
  'rpmforge-extras':
    descr       => "RHEL \$releasever - RPMforge.net -extras",
    enabled     => 1,
    baseurl     => "http://apt.sw.be/redhat/el6/en/\$basearch/extras",
    mirrorlist  => "http://apt.sw.be/redhat/el6/en/mirrors-rpmforge-extras",
    gpgcheck    => 0;
  'rpmforge-testing':
    descr       => "RHEL \$releasever - RPMforge.net -testing",
    enabled     => 1,
    baseurl     => "http://apt.sw.be/redhat/el6/en/\$basearch/testing",
    mirrorlist  => "http://apt.sw.be/redhat/el6/en/mirrors-rpmforge-testing",
    gpgcheck    => 0;
  
}


define installCPAN () {
  exec { "cpanLoad${title}":
    command => "/usr/local/bin/cpanm $name",
    path    => "/usr/bin:/usr/sbin:/bin:/sbin",
    unless  => "perl -I.cpan -M$title -e 1",
    timeout => 600,
    require => Exec["initCPAN"],
  }
}

exec { "initCPAN":
  command =>  "curl -L http://cpanmin.us | perl - --self-upgrade",
  path    => "/usr/bin:/usr/sbin:/bin:/sbin",
  creates  => "/usr/local/bin/cpanm"
}


define installNPM () {
  exec { "npmLoad${title}":
    command => "/usr/bin/npm install $name -g",
    path    => "/usr/bin:/usr/sbin:/bin:/sbin",
    unless  => "node -e \"var pkg = require( '$name' );\"",
    timeout => 600,
  }
}


package {
  'perl-CPANPLUS': ensure => 'installed';
  'perl-ExtUtils-MakeMaker': ensure => 'installed';
  'perl-AnyEvent': ensure => 'installed';
  'perl-AnyEvent-HTTP': ensure => 'installed';
  'perl-AnyEvent-EV': ensure => 'installed';


  'nodejs-compat-symlinks': ensure => 'installed';
  'npm': ensure => 'installed';

  'mysql': ensure => 'installed';
  'mysql-server': ensure => 'installed';
  'perl-DBD-MySQL': ensure => 'installed';
  
  'telnet': ensure => 'installed';
  'vim-minimal': ensure => 'installed';
}

# E.g.
installCPAN { "AnyEvent::HTTPD": }
installCPAN { "AnyEvent::DBI": }
installCPAN { "AnyEvent::AIO": }


service {
  'mysqld': ensure => 'running';
}

installNPM { "mysql": }
