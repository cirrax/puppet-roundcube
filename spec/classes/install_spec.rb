# frozen_string_literal: true

require 'spec_helper'

describe 'roundcube::install' do
  let :default_params do
    {  packages: ['roundcube'],
       package_ensure: 'installed' }
  end

  shared_examples 'roundcube::install shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_package('roundcube')
        .with_name('roundcube')
        .with_ensure(params[:package_ensure])
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'roundcube::install shared examples'
      end

      context 'with non defaults' do
        let :params do
          default_params.merge(
            packages: %w[somepackage roundcube],
            package_ensure: 'absent'
          )
        end

        it_behaves_like 'roundcube::install shared examples'

        it {
          is_expected.to contain_package('somepackage')
            .with_name('somepackage')
            .with_ensure(params[:package_ensure])
        }
      end
    end
  end
end
