class Crawler
  class SitemapBuilder
    attr_reader :graph, :file_path, :file_name

    def initialize(graph, options)
      @graph = graph
      @file_path = options.fetch(:file_path, "#{Dir.home}/Desktop/#{file_name}") # TODO: OSX specific need to change
      @file_name = options.fetch(:file_name, "sitemap_#{Time.now.to_i}.txt")
    end

    def build
      path = File.join(file_path, file_name)
      open(path, 'wb') do |file|
        file.write "Number of pages: #{graph.nodes.count}\n"
        write_nodes(file)
      end
    rescue => e
      warn "Couldn't write to file with error: #{e.backtrace}"
    end

    private

    def write_nodes(file)
      graph.nodes.each do |node|
        file.write(node.to_s)
      end
    end
  end
end
