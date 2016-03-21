require 'crawler'

desc 'builds a sitemap for a given url, also allows passing in config settings'
task :generate_sitemap, :url, :file_path, :file_name do |_, args|
  Crawler.build_sitemap_for(args[:url], args[:file_path], args[:file_name])
end
