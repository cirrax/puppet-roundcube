# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`roundcube`](#roundcube): the main roundcube class
* [`roundcube::config`](#roundcubeconfig): roundcube configuration
* [`roundcube::db`](#roundcubedb): configure database
* [`roundcube::db::mysql`](#roundcubedbmysql): crate a mysql db for roundcube
* [`roundcube::install`](#roundcubeinstall): install roundcube packages
* [`roundcube::params`](#roundcubeparams): summary params class  this will be move to hiera one day ! so do not use.
* [`roundcube::vhost`](#roundcubevhost): creates a vhost for roundcube
* [`roundcube::vhost::apache`](#roundcubevhostapache): internal class that installs an apache vhost Parameters are inherited from roundcube::vhost

### Defined types

* [`roundcube::plugin`](#roundcubeplugin): configures plugins

## Classes

### `roundcube`

the main roundcube class

#### Parameters

The following parameters are available in the `roundcube` class.

##### `ensure_database`

Data type: `Boolean`

if true a database is created
Defaults to false

Default value: ``false``

##### `ensure_vhost`

Data type: `Boolean`

if true a virtualhost is created
Defaults to false

Default value: ``false``

### `roundcube::config`

roundcube configuration

#### Parameters

The following parameters are available in the `roundcube::config` class.

##### `config_file`

Data type: `String`

configuration file to use

Default value: `$roundcube::params::config_file`

##### `configs`

Data type: `Hash`

Hash of configuration variables to set.
Defaults to {}

Default value: `{}`

##### `owner`

Data type: `String`

owner of the config file
Defaults to $roundcube::params::config_owner

Default value: `$roundcube::params::config_owner`

##### `group`

Data type: `String`

group of the config file
Defaults to $roundcube::params::config_group

Default value: `$roundcube::params::config_group`

##### `mode`

Data type: `String`

mode of the config file
Defaults to $roundcube::params::config_mode

Default value: `$roundcube::params::config_mode`

##### `include_db_config`

Data type: `String`



Default value: `$roundcube::params::include_db_config`

##### `plugins`

Data type: `Hash`

plugings with configuration to generate
(uses create_resources for roundcube::plugin
 define, simplifies hiera usage !)

Default value: `{}`

##### `plugin_config_dir`

Data type: `String`

the default config directory to use for plugins
only used if roundcube::config::plugins parameter
is used

Default value: `$roundcube::params::plugin_config_dir`

### `roundcube::db`

configure database

#### Parameters

The following parameters are available in the `roundcube::db` class.

##### `dbpass`

Data type: `String`

password to connect to the database.

Default value: `'CHANGEME'`

##### `dbtype`

Data type: `String`

database type to use currently only mysql is
supported.
defaults to 'mysql'

Default value: `'mysql'`

##### `dbname`

Data type: `String`

name of the database
defaults to: 'roundcube'

Default value: `'roundcube'`

##### `dbuser`

Data type: `String`

username to connect to the database.
defaults to: 'roundcube'

Default value: `'roundcube'`

##### `basepath`

Data type: `String`

basepath for database, defaults to ''

Default value: `''`

##### `dbport`

Data type: `String`

port to connect to db defaults to '3306' (mysql)

Default value: `'3306'`

##### `host`

Data type: `String`

host that is allowed to connect
defaults to 'localhost'

Default value: `'localhost'`

##### `dbconfig_inc`

Data type: `String`

where to write the db config.
defaults to '/etc/roundcube/debian-db.php'
if you do not want to write, set it to ''

Default value: `'/etc/roundcube/debian-db.php'`

### `roundcube::db::mysql`

crate a mysql db for roundcube

#### Parameters

The following parameters are available in the `roundcube::db::mysql` class.

##### `dbname`

Data type: `Any`

the name of the database

Default value: `$roundcube::db::dbname`

##### `dbuser`

Data type: `Any`

db user

Default value: `$roundcube::db::dbuser`

##### `dbpass`

Data type: `Any`

password for the user

Default value: `$roundcube::db::dbpass`

##### `host`

Data type: `Any`

database host

Default value: `$roundcube::db::host`

### `roundcube::install`

install roundcube packages

#### Parameters

The following parameters are available in the `roundcube::install` class.

##### `packages`

Data type: `Array`

the packages to install

Default value: `$roundcube::params::packages`

##### `package_ensure`

Data type: `String`

what to ensure for packages

Default value: `'installed'`

### `roundcube::params`

summary params class

this will be move to hiera one day !
so do not use.

### `roundcube::vhost`

This class chooses the type of vhost
to run webserver

#### Parameters

The following parameters are available in the `roundcube::vhost` class.

##### `vhosttype`

Data type: `String`

type of vhost to run. currently only apache supported (default)

Default value: `'apache'`

##### `servername`

Data type: `String`

Servername (defaults to $::fqdn)

Default value: `$::fqdn`

##### `serveraliases`

Data type: `Array`

Array of Serveraliasess to listen to (default [])

Default value: `[]`

##### `docroot`

Data type: `String`

Document root
defaults to $roundcube::params::docroot

Default value: `$roundcube::params::docroot`

##### `ssl`

Data type: `Boolean`

If true, use ssl (defaults to false)
If true, you also need to set cert, key and chain.

Default value: ``false``

##### `ssl_cert`

Data type: `String`

ssl cert to use

Default value: `unset`

##### `ssl_key`

Data type: `String`

ssl key to use

Default value: `unset`

##### `ssl_chain`

Data type: `String`

ssl chain to use

Default value: `unset`

##### `redirect_to_ssl`

Data type: `Boolean`

if true, redirects all non https requests to https
defaults to true.

Default value: ``true``

##### `create_resources`

Data type: `Hash`

a Hash of Hashes to create additional resources eg. to
retrieve a certificate.
Defaults to {} (do not create any additional resources)
Example (hiera):

roundcube::vhost::create_resources:
    sslcert::get_cert:
        get_my_roundcube_cert:
          private_key_path: '/etc/roundcube/ssl/key.pem'
          cert_path: '/etc/roundcube/ssl/cert.pem'

Will result in  executing:

sslcert::get_cert{'get_my_roundcube_cert':
  private_key_path => '/etc/roundcube/ssl/key.pem'
  cert_path        => '/etc/roundcube/ssl/cert.pem'
}

Default value: `{}`

### `roundcube::vhost::apache`

internal class that installs an apache vhost
Parameters are inherited from roundcube::vhost

#### Parameters

The following parameters are available in the `roundcube::vhost::apache` class.

##### `servername`

Data type: `String`



Default value: `$roundcube::vhost::servername`

##### `serveraliases`

Data type: `Array`



Default value: `$roundcube::vhost::serveraliases`

##### `docroot`

Data type: `String`



Default value: `$roundcube::vhost::docroot`

##### `apache_vhost`

Data type: `Hash`



Default value: `{}`

##### `ssl`

Data type: `Boolean`



Default value: `$roundcube::vhost::ssl`

##### `ssl_cert`

Data type: `String`



Default value: `$roundcube::vhost::ssl_cert`

##### `ssl_key`

Data type: `String`



Default value: `$roundcube::vhost::ssl_key`

##### `ssl_chain`

Data type: `String`



Default value: `$roundcube::vhost::ssl_chain`

##### `redirect_to_ssl`

Data type: `Boolean`



Default value: `$roundcube::vhost::redirect_to_ssl`

## Defined types

### `roundcube::plugin`

configures plugins

#### Parameters

The following parameters are available in the `roundcube::plugin` defined type.

##### `plugin_config_dir`

Data type: `Any`

directory

##### `configs`

Data type: `Any`

the configurations

Default value: `{}`

##### `plugin_name`

Data type: `Any`

name of the plugin

Default value: `$title`

##### `owner`

Data type: `Any`

owner of the config file

Default value: `'root'`

##### `group`

Data type: `Any`

group of the config file

Default value: `'root'`

##### `mode`

Data type: `Any`

mode of the config file

Default value: `'0644'`
