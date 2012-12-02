require 'fileutils'
require 'rspec'

$LIBCRASK_PATH="libcrask"
$LIBCRASK_INCLUDE_PATH="#{$LIBCRASK_PATH}/include"
$LIBCRASK_BUILD_PATH="#{$LIBCRASK_PATH}/build"

Before do
    $filesToRemove = []
    unless $libcraskIsBuilt
        output = %x(cmake -E make_directory "#{$LIBCRASK_BUILD_PATH}" && cmake -E chdir "#{$LIBCRASK_BUILD_PATH}" cmake .. && cmake --build "#{$LIBCRASK_BUILD_PATH}")
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

