class openvpn::server {
  include openvpn

  file {
    "/etc/openvpn/vpn.conf":
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
      content => Exec['generate dh'],
      ensure  => present,
      owner   => openvpn,
      group   => openvpn
  }
}
