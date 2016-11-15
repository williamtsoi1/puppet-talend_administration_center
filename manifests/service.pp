# == Class talend_administration_center::service
#
# This class is meant to be called from talend_administration_center.
# It ensure the service is running.
#
class talend_administration_center::service (
  $tomcat_service_name,
){
  if defined (Service[$tomcat_service_name]) {
    notify { 'restarting_tomcat':
      name    => 'restart_tomcat',
      message => 'restarting tomcat service',
      notify  => Service[$tomcat_service_name],
    }
  }
}
