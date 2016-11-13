# == Class talend_administration_center::params
#
# This class is meant to be called from talend_administration_center.
# It sets variables according to platform.
#
class talend_administration_center::params {
  $tomcat_service_name    = 'tomcat-default'
  $tac_war_url            = undef
  $generated_jobs_path    = '/Talend/Administrator/generatedJobs'
  $execution_logs_path    = '/Talend/Administrator/executionLogs'
  $audit_reports_path     = '/Talend/Audit/reports'
  $catalina_home          = '/opt/apache-tomcat'
  $tomcat_user            = 'tomcat'
  $tomcat_group           = 'tomcat'
  $tac_domain             = undef
  $tac_webapp_location    = 'org.talend.administrator'
  $tac_db_connectors_url  = undef
  $tac_db_driver          = 'org.h2.Driver'
  $tac_db_url             = 'jdbc:h2:~/talend_administrator;MV_STORE=FALSE;MVCC=TRUE;AUTO_SERVER=TRUE;LOCK_TIMEOUT=15000'
  $tac_db_username        = undef
  $tac_db_password        = undef
  $tac_db_config_password = 'password'
  case $::osfamily {
    'Debian', 'RedHat', 'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
