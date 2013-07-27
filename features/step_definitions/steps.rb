require 'fileutils'
require 'rspec'
require 'libcrask_paths'

$DEFAULT_RASK_SOURCE='example.rask'
$DEFAULT_C_OUTPUT='example.c'

Before do
  $filesToRemove = []
end

After do
  $filesToRemove.each { |f| File.delete(f) }
end

Given /^an empty file named "([^"]*)"$/ do |raskfile|
  FileUtils.touch raskfile
  $filesToRemove << raskfile
end

Given /^a file named "([^"]*)" with:$/ do |raskfile, source|
  File.open(raskfile, "w") { |f| f.write source }
  $filesToRemove << raskfile
end

Given /^source code:$/ do |source|
  File.open($DEFAULT_RASK_SOURCE, "w") { |f| f.write source }
    $filesToRemove << $DEFAULT_RASK_SOURCE
end

Given /^method body:$/ do |body|
  step "source code:", %Q{
    class Class {
      def method {
        #{body}
      }
    }
  }
end

When /^I translate it to C$/ do
  system "./bin/craskc -C #{$DEFAULT_RASK_SOURCE} #{$DEFAULT_C_OUTPUT}"
  $filesToRemove << $DEFAULT_C_OUTPUT
end

When /^I translate "([^"]*)" to C into "([^"]*)"$/ do |raskfile, cfile|
  system "./bin/craskc -C #{raskfile} #{cfile}"
  $filesToRemove << cfile
end

Then /^generated C code should contain:$/ do |source|
  File.open($DEFAULT_C_OUTPUT) { |f| f.read.should include(source) }
end

Then /^generated C code should compile$/ do
  gccOutput = %x(cc "#{$DEFAULT_C_OUTPUT}" -I"#{LIBCRASK_INCLUDE_PATH}" -L"#{LIBCRASK_BUILD_PATH}" -lcrask -o a.out 2>&1 && rm a.out)
  $?.exitstatus.should eql(0), gccOutput
end

Then /^file "([^"]*)" should contain:$/ do |cfile, source|
  File.open(cfile) { |f| f.read.should include(source) }
end

Then /^file "(.*?)" should contain lines:$/ do |cfile, lines|
  File.open(cfile) { |f|
    code = f.read
    lines.split("\n").each { |line|
      code.should include(line)
    }
  }
end

Then /^generated C code should contain lines:$/ do |lines|
  File.open($DEFAULT_C_OUTPUT) { |f|
    code = f.read
    lines.split("\n").each { |line|
      code.should include(line)
    }
  }
end

Then /^file "([^"]*)" should compile$/ do |cfile|
  gccOutput = %x(cc "#{cfile}" -I"#{LIBCRASK_INCLUDE_PATH}" -L"#{LIBCRASK_BUILD_PATH}" -lcrask -o a.out 2>&1 && rm a.out)
  $?.exitstatus.should eql(0), gccOutput
end

