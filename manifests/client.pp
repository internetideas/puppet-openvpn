define openvpn::client ($server) {
  include openvpn

  file { "/etc/openvpn/client.conf":
    content => template("openvpn/client.conf.erb"),
    ensure => present,
    owner => openvpn,
    group => openvpn,
    require => File["/etc/openvpn"];
  }

}
