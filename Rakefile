require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |s|
  s.name = 'Ant2Rake'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'Ant2Rake is a Ruby gem that automatically converts ant build.xml files to JRuby 1.5 build scripts'
  s.description = s.summary
  s.author = 'Kerry R Wilson'
  s.email = 'kwilson@goodercode.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "ant2rake Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.libs << Dir["lib"]
end

desc 'Do a test run'
task :test_convert do

  $: << File.join(File.dirname(__FILE__),'lib')
  require 'ant2rake'
  require 'ant2rake/cli'
  FileUtils.mkdir('pkg') unless File.directory? 'pkg'
  Ant2Rake::Cli::Runner.new(File.join(File.dirname(__FILE__),'test','build.xml'),File.join(File.dirname(__FILE__),'pkg','build.rb')).go

end