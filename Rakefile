require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new('test:units') do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/units/**/*_test.rb']
end

task test: 'test:units'
