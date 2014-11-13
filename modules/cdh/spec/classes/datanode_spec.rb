require 'spec_helper'

describe 'cdh::datanode' do
  it { should contain_class('cdh::datanode') }
end
