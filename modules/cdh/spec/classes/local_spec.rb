require 'spec_helper'

describe 'cdh::local' do
  let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'CentOS', :operatingsystemmajrelease => 6} }
  it { should contain_class('cdh::local') }
end
