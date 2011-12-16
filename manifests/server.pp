class openvpn::server {
  include openvpn

  service {
    "openvpn":
      ensure     => running,
      hasrestart => true,
      hasstatus  => true,
      require    => [ File["/etc/default/openvpn"], File["/etc/openvpn/server.conf"] ];
  }

  file {
    "/etc/openvpn/server.conf":
      content => template("openvpn/server.conf.erb"),
      ensure  => present,
      owner   => openvpn,
      group   => openvpn,
      require => [ File["/etc/openvpn"], File["/etc/openvpn/keys/dh1024.pem"] ];
  }

  package {
    "openssl":
      ensure => installed;
  }

  exec {
    "generate dh":
      command  => "openssl dhparam -out dh1024.pem 1024",
      cwd      => "/etc/openvpn/keys/",
      creates  => "/etc/openvpn/keys/dh1024.pem",
      provider => "shell",
      require  => [ File["/etc/openvpn/keys"], Package['openssl'] ];
  }

  file {
    "/etc/openvpn/keys/dh1024.pem":
      ensure  => present,
      owner   => openvpn,
      group   => openvpn,
      require => Exec['generate dh'];

  }
}
