require 'rdoc/task'

task :default => [:test, :PlayRockPaperScissorsGame, :rps]

file_path = "./test/test_rps.rb"

task :test do 
	ruby file_path
end

task :PlayRockPaperScissorsGame do
	ruby file_path
end

task :rps do
	ruby file_path
end

# rps = Regexp.new(/\A((PlayRockPaperScissorsGame)(\-)(\d\.\d\.\d)(\.gem))\z/)

RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  # rdoc.rdoc_files.include(`git ls-files -z`.split("\x0"))
  rdoc.rdoc_files.include(["lib/**/*.rb", "bin/**", "test/*.rb", "Gemfile", "Rakefile", "rps.gemspec", "README.md"])
  rdoc.rdoc_dir = "rdoc"
end
