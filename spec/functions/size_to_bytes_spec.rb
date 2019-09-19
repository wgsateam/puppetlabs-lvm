require 'spec_helper'

describe 'lvm::size_to_bytes' do
  context 'with incorrect parameters' do
    it 'should fail' do
      is_expected.to run.with_params('foo').and_raise_error(
        Puppet::PreformattedError, 
        /foo is not a valid LVM size/
      )
    end
  end

  context 'with lower case parameters' do
    it 'should return the correct values' do
      is_expected.to run.with_params('1k').and_return(1024)
      is_expected.to run.with_params('1m').and_return(1_048_576)
      is_expected.to run.with_params('1g').and_return(1_073_741_824)
      is_expected.to run.with_params('1t').and_return(1_099_511_627_776)
      is_expected.to run.with_params('1.0p').and_return(1.12589991e15)
      is_expected.to run.with_params('1.0e').and_return(1.1529215e18)
      is_expected.to run.with_params('200.0g').and_return(214_748_364_800.0)
      is_expected.to run.with_params('1.5k').and_return(1536.0)
    end
  end
end