# frozen_string_literal: true

require 'spec_helper'

describe 'roundcube::vhost::apache' do
  let :pre_condition do
    'class { "apache": mpm_module => "prefork" }'
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it {
        is_expected.to contain_apache__vhost('foo.example.com')
          .with_port(443)
      }
    end
  end
end
