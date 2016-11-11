require 'spec_helper'

describe 'talend_administration_center' do
  let(:facts) do
    {

    }
  end
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        case facts[:osfamily]
        when 'Debian'
          let(:facts) do
            {
              osfamily: 'Debian',
              staging_http_get: 'curl',
              path: '/usr/local/bin:/usr/bin:/bin',
            }
          end
        when 'RedHat'
          let(:facts) do
            {
              osfamily: 'RedHat',
              staging_http_get: 'curl',
              path: '/usr/local/bin:/usr/bin:/bin',
            }
          end
        end
        context "talend_administration_center class with minimum parameters" do
          let(:params) do
            {
              tac_war_url: 'http://foo.com/org.talend.administrator.war',
              tac_db_connectors_url: 'http://foo.com/connectors.zip',
              tac_domain: 'https://talend.mycompany.com',
            }
          end
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('talend_administration_center::params') }
          it { is_expected.to contain_class('talend_administration_center::install').that_comes_before('Class[talend_administration_center::config]') }
          it { is_expected.to contain_class('talend_administration_center::config') }
          it { is_expected.to contain_class('talend_administration_center::service').that_subscribes_to('Class[talend_administration_center::config]') }

          it { is_expected.to contain_service('tomcat-default') }
        end
      end
    end
  end
end
