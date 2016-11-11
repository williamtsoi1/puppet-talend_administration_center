# == Class talend_administration_center::install
#
# This class is called from talend_administration_center for install.
#
class talend_administration_center::install (
  tac_war_url           => $tac_war_url,
  generated_jobs_path   => $generated_jobs_path,
  execution_logs_path   => $execution_logs_path,
  audit_reports_path    => $audit_reports_path,
  catalina_home         => $catalina_home,
  tomcat_user           => $tomcat_user,
  tomcat_group          => $tomcat_group,
  tac_webapp_location   => $tac_webapp_location,
  tac_db_connectors_url => $tac_db_connectors_url,
){
  talend_administration_center::install::tac_webapp { 'default':
    tac_war_url         => $tac_war_url,
    catalina_home       => $catalina_home,
    tac_webapp_location => $tac_webapp_location,
    tomcat_user         => $tomcat_user,
    tomcat_group        => $tomcat_group,
  }

  talend_administration_center::install::tac_paths { 'default':
    generated_jobs_path => $generated_jobs_path,
    execution_logs_path => $execution_logs_path,
    audit_reports_path  => $audit_reports_path,
    tomcat_user         => $tomcat_user,
    tomcat_group        => $tomcat_group,
  }

  talend_administration_center::install::tac_db_connectors { 'default':
    tac_db_connectors_url => $tac_db_connectors_url,
    catalina_home         => $catalina_home,
    tomcat_user           => $tomcat_user,
    tomcat_group          => $tomcat_group,
  }
}
