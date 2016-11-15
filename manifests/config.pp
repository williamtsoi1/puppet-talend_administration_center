# == Class talend_administration_center::config
#
# This class is called from talend_administration_center for service config.
#
class talend_administration_center::config (
  $catalina_home,
  $tac_webapp_location,
  $tomcat_user,
  $tomcat_group,
  $tac_domain,
  $tac_db_driver,
  $tac_db_url,
  $tac_db_username,
  $tac_db_password,
  $tac_db_config_password,
){
  file { [
    "${catalina_home}/webapps/${tac_webapp_location}/WEB-INF",
    "${catalina_home}/webapps/${tac_webapp_location}/WEB-INF/classes",
  ]:
    ensure => 'directory',
    owner  => $tomcat_user,
    group  => $tomcat_group,
    mode   => '0644',
  }

  file { "${catalina_home}/webapps/${tac_webapp_location}/WEB-INF/classes/configuration.properties":
    content => template('talend_administration_center/configuration.properties.erb'),
    owner   => $tomcat_user,
    group   => $tomcat_group,
    mode    => '0644',
    require => File[
      "${catalina_home}/webapps/${tac_webapp_location}/WEB-INF",
      "${catalina_home}/webapps/${tac_webapp_location}/WEB-INF/classes"
    ],
  }
}
