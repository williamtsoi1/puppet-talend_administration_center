# == Class talend_administration_center::install
#
# This class is called from talend_administration_center for install.
#
class talend_administration_center::install (
  $tac_war_url,
  $generated_jobs_path,
  $execution_logs_path,
  $audit_reports_path,
  $catalina_home,
  $tomcat_user,
  $tomcat_group,
  $tac_webapp_location,
  $tac_db_connectors_url,
){
  include ::staging

  class { '::talend_administration_center::install::tac_webapp':
    tac_war_url         => $tac_war_url,
    catalina_home       => $catalina_home,
    tac_webapp_location => $tac_webapp_location,
    tomcat_user         => $tomcat_user,
    tomcat_group        => $tomcat_group,
  }

  class { '::talend_administration_center::install::tac_paths':
    generated_jobs_path => $generated_jobs_path,
    execution_logs_path => $execution_logs_path,
    audit_reports_path  => $audit_reports_path,
    tomcat_user         => $tomcat_user,
    tomcat_group        => $tomcat_group,
  }

  if $tac_db_connectors_url != undef {
    class { '::talend_administration_center::install::tac_db_connectors':
      tac_db_connectors_url => $tac_db_connectors_url,
      catalina_home         => $catalina_home,
      tomcat_user           => $tomcat_user,
      tomcat_group          => $tomcat_group,
    }
  }
}
