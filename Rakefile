require 'rake'
require 'rspec/core/rake_task'

task :deploy    => 'deploy:all'
task :default => :deploy

namespace :deploy do
  desc "Run The Deploy Commands"
  task :run_script do
    exec('spec/fixtures/deploy.sh')
  end

  task :all do
    %W[deploy:run_script deploy:bastion].each do |t|
      sh "bundle exec rake #{t}"
    end
  end

  task :default => :all


 targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    target = "_#{target}" if target == "default"
    targets << target
  end

    targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
    end
  end
end


desc "Setup The Test Environment"
task :setup do
  exec('spec/fixtures/setup.sh')
end



desc "Cleanup Any Remaining Openstack Resources"
task :cleanup do
  exec('spec/fixtures/cleanup.sh')
end
