# == Class talend_administration_center::service
#
# This class is meant to be called from talend_administration_center.
# It ensure the service is running.
#
class talend_administration_center::service (
  $tomcat_service_name,
){
  service { 'talend_administration_center-tomcat':
    ensure     => running,
    name       => $tomcat_service_name,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
