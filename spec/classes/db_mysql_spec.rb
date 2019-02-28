require 'spec_helper'


describe 'roundcube::db::mysql' do
  let(:pre_condition) { ['include mysql::params'] }
  let :facts do
    {
      :operatingsystemrelease => 'test',
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :lsbdistcodename        => 'Debian',
    }
  end

  let :default_params do
     { :dbname => 'roundcube',
       :dbuser => 'roundcube',
       :dbpass => 'CHANGEME',
       :host   => 'localhost',
     }
  end

  shared_examples 'roundcube::db::mysql shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_mysql__db( params[:dbname] )
      .with_user( params[:dbuser] )
      .with_host( params[:host] )
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end

    it_behaves_like 'roundcube::db::mysql shared examples'
  end

  context 'with non  defaults' do
    let :params do
      default_params.merge(
       :dbname => 'mydb',
       :dbuser => 'myuser',
       :dbpass => 'secret-password',
       :host   => 'myhost',
      )
    end
    it_behaves_like 'roundcube::db::mysql shared examples'
  end
end
