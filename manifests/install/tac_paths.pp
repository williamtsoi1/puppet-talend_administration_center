# Creates the necessary folders for TAC to work
class talend_administration_center::install::tac_paths (
  $generated_jobs_path,
  $execution_logs_path,
  $audit_reports_path,
  $tomcat_user,
  $tomcat_group,
){
  mkdir::p { $generated_jobs_path:
    owner => $tomcat_user,
    group => $tomcat_group,
    mode  => '0744',
  }

  mkdir::p { $execution_logs_path:
    owner => $tomcat_user,
    group => $tomcat_group,
    mode  => '0744',
  }

  mkdir::p { $audit_reports_path:
    owner => $tomcat_user,
    group => $tomcat_group,
    mode  => '0744',
  }
}
