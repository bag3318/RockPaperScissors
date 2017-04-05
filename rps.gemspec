Gem::Specification.new do |spec| 
  spec.name                             = "PlayRockPaperScissorsGame"
  spec.version                          = "2.3.7"
  spec.date                             = "2017-04-05"
  spec.summary                          = "A Rock Paper Scissors Ruby Gem"
  spec.description                      = <<-EOF 
    A Ruby-programmed rock paper scissors game. 
    Now you can play rock paper scissors on your computer whenever you'd like! :)
  EOF
  spec.author                           = "bag3318"
  spec.platform                         = Gem::Platform::RUBY
  spec.require_paths                    = ["lib"]
  spec.files                            = `git ls-files -z`.split("\x0")
  spec.test_files                       = ["./test/test_rps.rb"]
  spec.post_install_message             = "Thanks for installing! I hope you have fun playing rock paper scissors! :)"
  spec.license                          = "MIT"
  spec.homepage                         = "https://bag3318.github.io/RockPaperScissors/"
  spec.required_ruby_version            = ">= 2.0.0"
  spec.required_rubygems_version        = ">= 2.6.0"
  spec.extra_rdoc_files                 = "README.md"
  spec.cert_chain                       = ["./certs/gem-public_cert.pem"]
  spec.signing_key                      = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
  spec.bindir                           = "bin"
  spec.executables                     << "rps"
  spec.executables                     << "PlayRockPaperScissorsGame"
  spec.requirements                    << "A Windows or Mac computer"
  spec.metadata                         = { 
    "issue_tracker" => "https://github.com/bag3318/RockPaperScissors/issues", 
    "source_code"   => "https://github.com/bag3318/RockPaperScissors"       , 
    "releases"      => "https://github.com/bag3318/RockPaperScissors/releases" 
  }
  spec.add_runtime_dependency "bundler" , "~> 1.14.6"
  spec.add_runtime_dependency "colorize", "~> 0.8.1"
  spec.add_runtime_dependency "rake"    , "~> 12.0.0"
  spec.add_runtime_dependency "rvm"     , "~> 1.11.3.9"
  spec.add_development_dependency "rdoc", "~> 5.1.0"
end
