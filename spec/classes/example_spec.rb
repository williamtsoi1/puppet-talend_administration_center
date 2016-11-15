require 'spec_helper'

describe 'talend_administration_center' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        case facts[:osfamily]
        when 'Debian'
          let(:facts) do
            {
              osfamily: 'Debian',
              staging_http_get: 'curl',
              path: '/usr/local/bin:/usr/bin:/bin'
            }
          end
        when 'RedHat'
          let(:facts) do
            {
              osfamily: 'RedHat',
              staging_http_get: 'curl',
              path: '/usr/local/bin:/usr/bin:/bin'
            }
          end
        end
        context 'talend_administration_center class with no war url' do
          let(:params) do
            {
              tac_db_connectors_url: 'http://foo.com/connectors.zip',
              tac_domain: 'https://talend.mycompany.com'
            }
          end
          it { is_expected.to raise_error(Puppet::Error, /Unknown variable/) }
        end
        context 'talend_administration_center with default variables' do
          let(:params) do
            {
              tac_war_url: 'http://foo.com/org.talend.administrator.war'
            }
          end
          context 'install -> config ~> service pattern' do
            it { is_expected.to compile.with_all_deps }
            it { is_expected.to contain_class('talend_administration_center::params') }
            it { is_expected.to contain_class('talend_administration_center::install').that_comes_before('Class[talend_administration_center::config]') }
            it { is_expected.to contain_class('talend_administration_center::install::tac_paths') }
            it { is_expected.to contain_class('talend_administration_center::install::tac_webapp') }
            it { is_expected.to contain_class('talend_administration_center::config') }
            it { is_expected.to contain_class('talend_administration_center::service').that_subscribes_to('Class[talend_administration_center::config]') }
          end
          context 'configuration.properties' do
            it { is_expected.to contain_file('/opt/apache-tomcat/webapps/org.talend.administrator/WEB-INF/classes/configuration.properties').without_content(/conf.applicationStaticLocation/) }
            it { is_expected
              .to contain_file('/opt/apache-tomcat/webapps/org.talend.administrator/WEB-INF/classes/configuration.properties')
              .with_content(/database.url=jdbc:h2:~\/talend_administrator;MV_STORE=FALSE;MVCC=TRUE;AUTO_SERVER=TRUE;LOCK_TIMEOUT=15000/)
              .with_content(/database.driver=org.h2.Driver/)
              .without_content(/database.username/)
              .without_content(/database.password/)
            }
          end
          context 'correct directories created' do
            it { is_expected.to contain_mkdir__p('/Talend/Administrator/executionLogs') }
            it { is_expected.to contain_mkdir__p('/Talend/Administrator/generatedJobs') }
            it { is_expected.to contain_mkdir__p('/Talend/Audit/reports') }
            it { is_expected.to contain_file('/opt/apache-tomcat/webapps/org.talend.administrator/WEB-INF/classes') }
            it { is_expected.to contain_file('/opt/apache-tomcat/webapps/org.talend.administrator') }
          end
          context 'war deployed' do
            it { is_expected.to contain_staging__deploy('org.talend.administrator.war')}
          end
        end
        context 'talend_administration_center with mysql database' do
          let(:params) do
            {
              tac_war_url: 'http://foo.com/org.talend.administrator.war',
              tac_db_driver: 'com.mysql.jdbc.Driver',
              tac_db_url: 'jdbc:mysql://talenddb:3306/talend_administrator',
              tac_db_username: 'tisadmin',
              tac_db_password: 'Password01',
              tac_db_config_password: 'Password02'
            }
          end
          it { is_expected
            .to contain_file('/opt/apache-tomcat/webapps/org.talend.administrator/WEB-INF/classes/configuration.properties')
            .with_content(/database.url=jdbc:mysql:\/\/talenddb:3306\/talend_administrator/)
            .with_content(/database.driver=com.mysql.jdbc.Driver/)
            .with_content(/database.username=tisadmin/)
            .with_content(/database.password=Password01/)
            .with_content(/database.config.password=Password02/)
          }
        end
        context 'talend_administration_center with custom tomcat parameters' do
          let(:params) do
            {
              tac_war_url: 'http://foo.com/org.talend.administrator.war',
              tomcat_service_name: 'custom-tomcat',
              catalina_home: '/opt/custom-tomcat',
              tomcat_user: 'custom_tomcat',
              tomcat_group: 'custom_tomcat',
              tac_domain: 'https://talend.mycompany.com',
              tac_webapp_location: 'tac'
            }
          end
          context 'correct configuration.properties' do
            it { is_expected.to contain_file('/opt/custom-tomcat/webapps/tac/WEB-INF/classes/configuration.properties').with_content(/conf.applicationStaticLocation=https:\/\/talend.mycompany.com\/tac/) }
          end
          context 'correct directories created' do
            it { is_expected.to contain_mkdir__p('/Talend/Administrator/executionLogs') }
            it { is_expected.to contain_mkdir__p('/Talend/Administrator/generatedJobs') }
            it { is_expected.to contain_mkdir__p('/Talend/Audit/reports') }
            it { is_expected.to contain_file('/opt/custom-tomcat/webapps/tac/WEB-INF/classes') }
            it { is_expected.to contain_file('/opt/custom-tomcat/webapps/tac') }
          end
        end
      end
    end
  end
end
