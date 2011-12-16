define openvpn::server {
  include openvpn

  file { "/etc/openvpn/server.conf":
    content => template("openvpn-server/server.conf.erb"),
    ensure => present,
    owner => openvpn,
    group => openvpn,
    require => File["/etc/openvpn"];
  }

}
