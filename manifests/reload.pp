# = Class: resolvconf::reload
#
# Regenerate `resolv.conf` due to changes in `resolv.conf.d`.
#
class resolvconf::reload {
  exec { '/sbin/resolvconf -u':
    refreshonly => true,
  }
  exec { '/bin/rm /run/resolvconf/interface/*':
    refreshonly => true,
    onlyif      => ["/usr/bin/test -f /run/resolvconf/interface/eth*"]
  }
  exec { '/bin/sed -i \'/# DNS/!s/dns-.*$/# DNS managed by Puppet!  &/\' /etc/network/interfaces':
    refreshonly => true,
  }
}
