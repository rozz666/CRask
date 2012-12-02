require 'fileutils'
require 'rspec'
require 'libcrask_paths'

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
    f = File.new(raskfile, "w")
    f.write(source)
    f.close
    $filesToRemove << raskfile
end

When /^I translate "([^"]*)" to C into "([^"]*)"$/ do |raskfile, cfile|
    system "./bin/craskc -C #{raskfile} #{cfile}"
    $filesToRemove << cfile
end

Then /^file "([^"]*)" should contain:$/ do |cfile, source|
    File.open(cfile).read.should include(source)
end

Then /^file "([^"]*)" should compile$/ do |cfile|
    gccOutput = %x(cc "#{cfile}" -I"#{$LIBCRASK_INCLUDE_PATH}" -L"#{$LIBCRASK_BUILD_PATH}" -lcrask -o a.out 2>&1 && rm a.out)
    $?.exitstatus.should be(0), gccOutput
end

