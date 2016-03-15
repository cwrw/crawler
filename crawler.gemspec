Gem::Specification.new do |s|
  s.name        = 'crawler'
  s.version     = '0.0.0'
  s.date        = '2016-03-15'
  s.summary     = "Crawler"
  s.description = "Crawls all the things"
  s.authors     = ["Abeer Salameh"]
  s.email       = 'abeer.salameh@gmail.com'
  s.files       = ["lib/crawler.rb"]
  s.homepage    = 'http://github.com/cwrw/crawler'
  s.license     = 'MIT'
  s.files       = ["README.md"] + Dir["lib/**/*.*"]
  s.executables = ["crawler"]

  s.add_dependency "nokogiri", "~> 1.6"
  s.add_development_dependency "rake", "~> 10.5"
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "rubocop", "~> 0.37"
  s.add_development_dependency "capybara", "~> 2.6"
  s.add_development_dependency "guard", "~> 2.1"
  s.add_development_dependency "guard-rspec", "~> 4.6"
  s.add_development_dependency "pry-byebug", "~> 3.0"
end
