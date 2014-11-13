require 'spec_helper'

describe 'cdh::config' do
  it { should contain_class('cdh::config') }
end
