require 'spec_helper'

describe 'talend_administration_center' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "talend_administration_center class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('talend_administration_center::params') }
          it { is_expected.to contain_class('talend_administration_center::install').that_comes_before('talend_administration_center::config') }
          it { is_expected.to contain_class('talend_administration_center::config') }
          it { is_expected.to contain_class('talend_administration_center::service').that_subscribes_to('talend_administration_center::config') }

          it { is_expected.to contain_service('talend_administration_center') }
          it { is_expected.to contain_package('talend_administration_center').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'talend_administration_center class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('talend_administration_center') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
