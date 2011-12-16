define openvpn::client ($server) {
  include openvpn

  file {
    "/etc/openvpn/${title}.conf":
      content => template("openvpn/client.conf.erb"),
      ensure  => present,
      owner   => openvpn,
      group   => openvpn,
      require => File["/etc/openvpn"];
  }

  service {
    "openvpn":
      ensure     => running,
      hasrestart => true,
      hasstatus  => true,
      require    => [ File["/etc/default/openvpn"], File["/etc/openvpn/${title}.conf"] ];
  }

}
