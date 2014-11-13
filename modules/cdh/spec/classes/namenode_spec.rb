require 'spec_helper'

describe 'cdh::namenode' do
  it { should contain_class('cdh::namenode') }
end

