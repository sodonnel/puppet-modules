require 'spec_helper'

describe 'cdh::metastore' do
  let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'CentOS', :operatingsystemmajrelease => 6} }
  it { should contain_class('cdh::metastore') }
end
