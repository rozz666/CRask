require 'libcrask_paths'
require 'rake/clean'

RACC_PARSER_REX='lib/crask/racc_parser.rex'
GENERATED_RACC_PARSER_REX='lib/crask/racc_parser.rex.rb'
RACC_PARSER='lib/crask/racc_parser.racc'
GENERATED_RACC_PARSER='lib/crask/racc_parser.tab.rb'

CLEAN.include(GENERATED_RACC_PARSER_REX)
CLEAN.include(GENERATED_RACC_PARSER)
CLOBBER.include(LIBCRASK_BUILD_PATH)


task :default => :test

file GENERATED_RACC_PARSER_REX => RACC_PARSER_REX do
  sh "rex #{RACC_PARSER_REX} -o #{GENERATED_RACC_PARSER_REX}"
end

file GENERATED_RACC_PARSER => RACC_PARSER do
  sh "racc #{RACC_PARSER} -o #{GENERATED_RACC_PARSER}"
end

desc "build libcrask"
task :libcrask do
  sh "cmake -E make_directory \"#{LIBCRASK_BUILD_PATH}\""
  sh "cmake -E chdir \"#{LIBCRASK_BUILD_PATH}\" cmake .."
  sh "cmake --build \"#{LIBCRASK_BUILD_PATH}\" --target crask"
end

desc "run libcrask tests"
task :libcrask_ut => :libcrask do
  sh "cmake --build \"#{LIBCRASK_BUILD_PATH}\" --target crask_ut"
  sh "#{LIBCRASK_BUILD_PATH}/crask_ut"
end

desc "generate grammar parsers"
task :grammar => [ GENERATED_RACC_PARSER_REX, GENERATED_RACC_PARSER ] do
end

desc "run spec examples"
task :spec => :grammar do
  sh 'rspec'
end

desc "run feature scenarios"
task :features => [:grammar, :libcrask] do
  sh 'cucumber -p regression'
end

desc "run WIP feature scenarios"
task :wip_features => [:grammar, :libcrask] do
  sh 'cucumber -p wip'
end

desc "run all examples and scenarios (default)"
task :test => [:libcrask_ut, :spec, :features] do
end

desc "run all examples and WIP scenarios"
task :wip => [:libcrask_ut, :spec, :wip_features] do
end

task :clean do
  sh "cmake --build \"#{LIBCRASK_BUILD_PATH}\" --target clean" if File.exists?("#{LIBCRASK_BUILD_PATH}")
end
