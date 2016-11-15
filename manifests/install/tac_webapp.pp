# This installs the Talend webapp into an existing Tomcat installation
class talend_administration_center::install::tac_webapp (
  $tac_war_url,
  $catalina_home,
  $tac_webapp_location,
  $tomcat_user,
  $tomcat_group,
){

  file { [
    "${catalina_home}/webapps",
    "${catalina_home}/webapps/${tac_webapp_location}",
  ]:
    ensure => 'directory',
    owner  => $tomcat_user,
    group  => $tomcat_group,
    mode   => '0644',
  }

  staging::deploy { 'org.talend.administrator.war':
    source  => $tac_war_url,
    target  => "${catalina_home}/webapps/${tac_webapp_location}/",
    user    => $tomcat_user,
    group   => $tomcat_group,
    require => File[
      "${catalina_home}/webapps",
      "${catalina_home}/webapps/${tac_webapp_location}"
    ],
  }
}
