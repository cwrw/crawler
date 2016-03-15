require 'crawler'

desc 'builds a sitemap for a given url, also allows passing in config settings'
task :generate_sitemap, :url, :options do |_, args|
  Crawler.build_sitemap_for(args[:url])
end
