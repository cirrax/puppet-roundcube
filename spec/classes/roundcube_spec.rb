# frozen_string_literal: true

require 'spec_helper'

describe 'roundcube' do
  let(:pre_condition) { ['include mysql::params'] }

  let :default_params do
    { ensure_database: false,
      ensure_vhost: false }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      shared_examples 'roundcube shared examples' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('roundcube::install') }
        it { is_expected.to contain_class('roundcube::config') }
      end

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'roundcube shared examples'

        it { is_expected.not_to contain_class('roundcube::db') }
        it { is_expected.not_to contain_class('roundcube::vhost') }
      end

      context 'with db' do
        let :params do
          default_params.merge(ensure_database: true)
        end

        it_behaves_like 'roundcube shared examples'

        it { is_expected.to contain_class('roundcube::db') }
        it { is_expected.not_to contain_class('roundcube::vhost') }
      end

      # context 'with vhost' do
      #   let :params do
      #     default_params.merge( :ensure_vhost => true )
      #   end
      #   it_behaves_like 'roundcube shared examples'

      #   it { is_expected.to_not contain_class('roundcube::db') }
      #   it { is_expected.to contain_class('roundcube::vhost') }
      # end
    end
  end
end
