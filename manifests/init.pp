class openvpn {

    package {
        "openvpn":
            ensure => installed;
    }

    service {
        "openvpn":
            ensure     => running,
            hasrestart => true,
            hasstatus  => true,
            require    => Exec["/etc/default/openvpn concatenation"];
    }

    file {
        "/etc/openvpn":
            ensure  => directory,
            require => Package["openvpn"];
    }

    file {
        "/etc/openvpn/keys":
            ensure  => directory,
            require => File["/etc/openvpn"];
    }

    file {
      "/etc/default/openvpn":
            ensure  => present,
            content => template("openvpn/etc-default-openvpn.erb"),
            notify  => Service["openvpn"];
    }

    user {
        "openvpn":
            ensure => present,
            comment => "OpenVPN user created by puppet",
            managehome => true,
            shell   => "/bin/false"
    }

}
