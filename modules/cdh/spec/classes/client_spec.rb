require 'spec_helper'

describe 'cdh::client' do
  it { should contain_class('cdh::client') }
end
