require "bundler/gem_tasks"
require "rake/testtask"
require "standard/rake"

Rake::TestTask.new("test:features") do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/features/**/*_test.rb"]
end

Rake::TestTask.new("test:units") do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/units/**/*_test.rb"]
end

task test: %i[test:units test:features]
