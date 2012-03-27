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

package {
  'perl-AnyEvent': ensure => 'installed';
  'perl-AnyEvent-HTTP': ensure => 'installed';


  'nodejs-compat-symlinks': ensure => 'installed';
  'npm': ensure => 'installed';

}