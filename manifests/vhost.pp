#
# @summary creates a vhost for roundcube
#
# This class chooses the type of vhost 
# to run webserver
#
# @param vhosttype
#    type of vhost to run. currently only apache supported (default)
# @param servername
#    Servername (defaults to $::fqdn)
# @param serveraliases
#    Array of Serveraliasess to listen to (default [])
# @param docroot
#    Document root
# @param ssl
#    If true, use ssl (defaults to false)
#    If true, you also need to set cert, key and chain.
# @param ssl_cert
#    ssl cert to use 
# @param ssl_key
#    ssl key to use
# @param ssl_chain
#    ssl chain to use
# @param redirect_to_ssl
#    if true, redirects all non https requests to https
#    defaults to true.
# @param create_resources
#    a Hash of Hashes to create additional resources eg. to 
#    retrieve a certificate.
#    Defaults to {} (do not create any additional resources)
#    Example (hiera):
#
#    roundcube::vhost::create_resources:
#        sslcert::get_cert:
#            get_my_roundcube_cert:
#              private_key_path: '/etc/roundcube/ssl/key.pem'
#              cert_path: '/etc/roundcube/ssl/cert.pem'
#
#    Will result in  executing:
#
#    sslcert::get_cert{'get_my_roundcube_cert':
#      private_key_path => '/etc/roundcube/ssl/key.pem'
#      cert_path        => '/etc/roundcube/ssl/cert.pem'
#    }
#
class roundcube::vhost (
  String                         $vhosttype        = 'apache',
  String                         $servername       = $facts['networking']['fqdn'],
  Array                          $serveraliases    = [],
  Stdlib::Absolutepath           $docroot          = '/var/lib/roundcube',
  Boolean                        $ssl              = false,
  Optional[Stdlib::Absolutepath] $ssl_cert         = undef,
  Optional[Stdlib::Absolutepath] $ssl_key          = undef,
  Optional[Stdlib::Absolutepath] $ssl_chain        = undef,
  Boolean                        $redirect_to_ssl  = true,
  Hash                           $create_resources = {},
) {
  case $vhosttype {
    'apache': { include roundcube::vhost::apache }
    default: { fail("Webserver '${vhosttype}' is not supported") }
  }

  $create_resources.each | $res, $vals | {
    create_resources($res, $vals )
  }
}
