# Installs the required database connectors into the Tomcat libs directory
class talend_administration_center::install::tac_db_connectors (
  $tac_db_connectors_url,
  $catalina_home,
  $tomcat_user,
  $tomcat_group,
){
  mkdir::p { "${catalina_home}/lib":
    owner        => $tomcat_user,
    group        => $tomcat_group,
    mode         => '0744',
    declare_file => true,
  }

  staging::deploy { 'db_connectors.zip':
    source => $tac_db_connectors_url,
    target => "${catalina_home}/lib",
    user   => $tomcat_user,
    group  => $tomcat_group,
  }
}
