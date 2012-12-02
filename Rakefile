task :default => :test

file 'lib/crask/racc_parser.rex.rb' => 'lib/crask/racc_parser.rex' do
  sh 'rex lib/crask/racc_parser.rex -o lib/crask/racc_parser.rex.rb'
end

file 'lib/crask/racc_parser.tab.rb' => 'lib/crask/racc_parser.racc' do
  sh 'racc lib/crask/racc_parser.racc -o lib/crask/racc_parser.tab.rb'
end

desc "generate grammar parsers"
task :grammar => [ 'lib/crask/racc_parser.rex.rb', 'lib/crask/racc_parser.tab.rb' ] do
end

desc "run spec examples"
task :spec => :grammar do
  sh 'rspec'
end

desc "run feature scenarios"
task :features => :grammar do
  sh 'cucumber -f progress'
end

desc "run all examples and scenarios"
task :test => [:spec, :features] do
end

desc "clean"
task :clean do
  rm 'lib/crask/racc_parser.rex.rb'
  rm 'lib/crask/racc_parser.tab.rb'
end