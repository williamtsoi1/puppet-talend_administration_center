# This installs the Talend webapp into an existing Tomcat installation
class talend_administration_center::install::tac_webapp (
  $tac_war_url,
  $catalina_home,
  $tac_webapp_location,
  $tomcat_user,
  $tomcat_group,
){
  mkdir::p { "${catalina_home}/webapps/${tac_webapp_location}":
    owner        => $tomcat_user,
    group        => $tomcat_group,
    mode         => '0744',
    declare_file => true,
  }

  staging::deploy { 'org.talend.administrator.war':
    source => $tac_war_url,
    target => "${catalina_home}/webapps/${tac_webapp_location}/",
  }
}
