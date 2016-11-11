# == Class talend_administration_center::service
#
# This class is meant to be called from talend_administration_center.
# It ensure the service is running.
#
class talend_administration_center::service (
  $tomcat_service_name,
){
  service { $tomcat_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
