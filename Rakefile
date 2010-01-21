require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'
require 'lib/pubcouch'

RELEASE = '0.0.1'

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Clear the existing Pubchem'
task :pull_test, :database, :email do |t, args|
  puts "Creating a new PubCouch database called '#{args.database}' in test mode (one file only)"
  loader = PubCouch::Loader.new :database => args.database, :email => args.email, :test => true
  
  puts "Loading first batch of Structures from CURRENT-Full..."
  loader.load_full
end

desc 'Generate RDoc documentation for PubCouch.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE').include('lib/**/*.rb')
  
  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "PubCouch Documentation"
  
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--inline-source' << '--charset=UTF-8'
end

