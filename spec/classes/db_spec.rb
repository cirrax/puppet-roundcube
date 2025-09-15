# frozen_string_literal: true

require 'spec_helper'

describe 'roundcube::db' do
  let(:pre_condition) { ['include mysql::params'] }

  let :default_params do
    { dbtype: 'mysql',
      dbname: 'roundcube',
      dbuser: 'roundcube',
      dbpass: 'CHANGEME',
      host: 'localhost',
      dbconfig_inc: '/etc/roundcube/debian-db.php' }
  end

  shared_examples 'roundcube::db shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_class('roundcube::db::mysql')
    }

    it {
      is_expected.to contain_file(params[:dbconfig_inc])
        .with_owner('root')
        .with_group('www-data')
        .with_mode('0640')
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'roundcube::db shared examples'
        it {
          is_expected.to contain_file(params[:dbconfig_inc])
            .with_owner('root')
            .with_group('www-data')
            .with_mode('0640')
        }
      end

      context 'without dbconfig file' do
        let :params do
          default_params.merge(
            dbconfig_inc: ''
          )
        end

        it { is_expected.not_to contain_file('/etc/roundcube/dbconfig.inc.php') }
      end
    end
  end
end
