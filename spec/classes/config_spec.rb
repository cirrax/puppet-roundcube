# frozen_string_literal: true

require 'spec_helper'

describe 'roundcube::config' do
  let :default_params do
    { config_file: '/etc/roundcube/config.inc.php',
      configs: {},
      owner: 'root',
      group: 'www-data',
      mode: '0640',
      include_db_config: '/etc/roundcube/debian-db-roundcube.php',
      plugins: {},
      plugin_config_dir: '/etc/roundcube/plugins' }
  end

  shared_examples 'roundcube::config shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_file(params[:config_file])
        .with_owner(params[:owner])
        .with_group(params[:group])
        .with_mode(params[:mode])
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'roundcube::config shared examples'

        it { is_expected.not_to contain_file_line('roudcube include local config') }
      end

      context 'with non defaults' do
        let :params do
          default_params.merge(
            config_file: '/tmp/test',
            owner: 'someone',
            group: 'somegroup',
            mode: '4242'
          )
        end

        it_behaves_like 'roundcube::config shared examples'
      end
    end
  end
end
