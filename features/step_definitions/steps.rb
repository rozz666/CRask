require 'fileutils'
require 'rspec'

Before do
    $filesToRemove = []
    unless $libcraskIsBuilt
        output = %x(cmake -E make_directory libcrask/build && cmake -E chdir libcrask/build cmake .. && cmake --build libcrask/build)
        $?.exitstatus.should be(0), output
        $libcraskIsBuilt = true
    end
end

After do
    $filesToRemove.each { |f| File.delete(f) }
end

Given /^an empty file named "([^"]*)"$/ do |raskfile|
    FileUtils.touch raskfile
    $filesToRemove << raskfile
end

Given /^a file named "([^"]*)" with:$/ do |raskfile, source|
    File.new(raskfile, "w").write(source)
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
    gccOutput = %x(gcc "#{cfile}" -Ilibcrask/include -o a.out 2>&1 && rm a.out)
    $?.exitstatus.should be(0), gccOutput
end

