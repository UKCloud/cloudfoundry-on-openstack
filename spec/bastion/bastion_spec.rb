require 'spec_helper'
describe "Bastion has the necessary deployment tools:" do

  describe command('git --version') do
    its(:stdout) { should match /git/ }
  end


  describe command('ruby -v') do
    its(:stdout) { should match /ruby 2/ }
  end


  describe file('/home/ubuntu/workspace/settings.yml') do
      it { should exist }
  end


  describe command('/usr/bin/traveling-bosh/bosh -v') do
    its(:stdout) { should match /BOSH/ }
  end


  describe command('/usr/bin/traveling-cf-admin/cf -v') do
    its(:stdout) { should match /cf version/ }
  end

end

describe "It Deployed A BOSH Micro Instance Succesfully:" do

  describe command('cd /home/ubuntu/workspace && /home/ubuntu/bin/traveling-bosh/bosh -u admin -p admin target https://192.168.2.10:25555') do
    its(:exit_status) { should eq 0 }
  end


  after(:all) do

    puts "CLEANING UP"

      #command('cd /home/ubuntu/workspace && /home/ubuntu/bin/traveling-bosh/bosh bootstrap delete')
  end


end
