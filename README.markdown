#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with talend_administration_center](#setup)
    * [What talend_administration_center affects](#what-talend_administration_center-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with talend_administration_center](#beginning-with-talend_administration_center)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module will install an instance of Talend Administration Center onto an existing Tomcat installation.

## Module Description

This module will:
* Install the Talend Administration Center web application from a given URL into an existing Tomcat installation.
* Install the required ojdbc connectors in order to connect to the TAC database
* Create the required directories for Talend Administration Center for storing files

This module requires the user to supply a URL containing the org.talend.administrator.war file. This may be in the form of local files, puppet://, http://, https://, ftp:// or s3://.

This module does not install Java or Tomcat itself, but rather, depends on the user to have set this up using another module (eg. puppetlabs-tomcat and puppetlabs-java), and then supplying the $CATALINA_HOME parameter into the module.

This module also does not automatically find the required ojdbc connectors. This also need to be supplied in the form of a compressed file (see puppet-staging for the supported types), with the location specified as a local file, puppet://, http://, https://, ftp:// or s3://.

## Usage

### Basic setup using embedded H2 database
~~~~
class { '::talend_administration_center':
  tac_war_url => 'http://foo.com/org.talend.administrator.war',
  tac_domain  => 'https://talend.mycompany.com',
}
~~~~
### Setup using external MySQL database
~~~~
class { '::talend_administration_center':
  tac_war_url            => 'http://foo.com/org.talend.administrator.war',
  tac_domain             => 'https://talend.mycompany.com',
  tac_db_connectors_url  => 'http://foo.com/mysql-connector-java-5.1.40.tar.gz',
  tac_db_driver          => 'org.gjt.mm.mysql.Driver',
  tac_db_url             => 'jdbc:mysql://talenddb:3306/talend_administrator',
  tac_db_username        => 'talend',
  tac_db_password        => 'password',
  tac_db_config_password => 'password2',
}
~~~~
### Setup using custom Tomcat parameters
~~~~
class { '::talend_administration_center':
  tac_war_url         => 'http://foo.com/org.talend.administrator.war',
  tac_domain          => 'https://talend.mycompany.com',
  tomcat_service_name => 'tomcat_default',
  catalina_home       => '/opt/apache-tomcat',
  tomcat_user         => 'tomcat',
  tomcat_group        => 'tomcat',
  tac_webapp_location => 'org.talend.administrator',
}
~~~~
## Limitations

TODO: This is where you list OS compatibility, version compatibility, etc.

## Development

TODO: Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.
