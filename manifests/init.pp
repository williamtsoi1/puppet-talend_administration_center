# Class: talend_administration_center
# ===========================
#
# Installs and configures the Talend Administration Center Tomcat application.
# This assumes that the machine already has a working Tomcat installation as a
# peer dependency.
#
# Parameters
# ----------
#
# * `tomcat_service_name`
#   The name of the service of the running Tomcat. This service will be restarted
#   after configuration of Talend Administration Center
#
# * `tac_war_url`
#   The location of the Talend Administration Center WAR file
#   supports local files, puppet://, http://, https://, ftp://, s3://
#   Required: True
#
# * `generated_jobs_path`
#   A folder location to store compiled/generated Talend jobs
#   Default: /Talend/Administrator/generatedJobs
#
# * `execution_logs_path`
#   A folder location to store execution logs of Talend job runs
#   Default: /Talend/Administrator/executionLogs
#
# * `audit_reports_path`
#   A folder location to store audit reports
#   Default: /Talend/Audit/reports
#
# * `catalina_home`
#   The folder location of CATALINA_HOME so the TAC WAR can be installed here
#   Default: /opt/apache-tomcat
#
# * `tac_domain`
#   The Fully Qualified Domain Name (FQDN) of the TAC instance. This is used for
#   the Talend CommandLine to connect to the TAC
#
# * `tac_webapp_location`
#   The location of the webapp in Apache Tomcat
#   Default: org.talend.administrator
#
# * `tac_db_connectors_url`
#   The location of a compressed file containing the required database connectors
#   supports local files, puppet://, http://, https://, ftp://, s3://
#
# * `tac_db_driver`
#   The JDBC driver to be used to connect to the TAC database. Needs to be one of:
#       org.h2.driver
#       org.gjt.mm.mysql.Driver
#       oracle.jdbc.driver.OracleDriver
#       net.sourceforge.jtds.jdbc.Driver
#       org.mariadb.jdbc.Driver
#       org.postgresql.Driver
#   Default: org.h2.Driver
#
# * `tac_db_url`
#   The full JDBC URL for the TAC database
#
# * `tac_db_username`
#   Username of the TAC database
#
# * `tac_db_password`
#   Password of the user of the TAC database
#
# * `tac_db_config_password`
#   Password used to access the Database Configuration page of TAC
#   Default: password

class talend_administration_center (
  $tomcat_service_name    = $::talend_administration_center::params::tomcat_service_name,
  $tac_war_url            = $::talend_administration_center::params::war_url,
  $generated_jobs_path    = $::talend_administration_center::params::generated_jobs_path,
  $execution_logs_path    = $::talend_administration_center::params::execution_logs_path,
  $audit_reports_path     = $::talend_administration_center::params::audit_reports_path,
  $catalina_home          = $::talend_administration_center::params::catalina_home,
  $tomcat_user            = $::talend_administration_center::params::tomcat_user,
  $tomcat_group           = $::talend_administration_center::params::tomcat_group,
  $tac_domain             = $::talend_administration_center::params::tac_domain,
  $tac_webapp_location    = $::talend_administration_center::params::tac_webapp_location,
  $tac_db_connectors_url  = $::talend_administration_center::params::tac_db_connectors_url,
  $tac_db_driver          = $::talend_administration_center::params::tac_db_driver,
  $tac_db_url             = $::talend_administration_center::params::tac_db_url,
  $tac_db_username        = $::talend_administration_center::params::tac_db_username,
  $tac_db_password        = $::talend_administration_center::params::tac_db_password,
  $tac_db_config_password = $::talend_administration_center::params::tac_db_config_password,
) inherits ::talend_administration_center::params {

  # validate parameters here
  validate_string($tomcat_service_name)
  validate_string($tac_war_url)
  validate_absolute_path($generated_jobs_path)
  validate_absolute_path($execution_logs_path)
  validate_absolute_path($audit_reports_path)
  validate_absolute_path($catalina_home)
  validate_string($tac_domain)
  validate_string($tac_webapp_location)
  validate_string($tac_db_connectors_url)
  validate_string($tac_db_driver)
  validate_string($tac_db_url)
  validate_string($tac_db_username)
  validate_string($tac_db_password)
  validate_string($tac_db_config_password)

  class { '::talend_administration_center::install':
    tac_war_url           => $tac_war_url,
    generated_jobs_path   => $generated_jobs_path,
    execution_logs_path   => $execution_logs_path,
    audit_reports_path    => $audit_reports_path,
    catalina_home         => $catalina_home,
    tac_webapp_location   => $tac_webapp_location,
    tomcat_user           => $tomcat_user,
    tomcat_group          => $tomcat_group,
    tac_db_connectors_url => $tac_db_connectors_url,
  } ->
  class { '::talend_administration_center::config':
    catalina_home          => $catalina_home,
    tac_webapp_location    => $tac_webapp_location,
    tomcat_user            => $tomcat_user,
    tomcat_group           => $tomcat_group,
    tac_domain             => $tac_domain,
    tac_db_driver          => $tac_db_driver,
    tac_db_url             => $tac_db_url,
    tac_db_username        => $tac_db_username,
    tac_db_password        => $tac_db_password,
    tac_db_config_password => $tac_db_config_password,
  } ~>
  class { '::talend_administration_center::service':
    tomcat_service_name => $tomcat_service_name,
  } ->
  Class['::talend_administration_center']
}
