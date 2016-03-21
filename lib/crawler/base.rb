class Crawler
  attr_reader :base_uri, :graph, :seen_uri

  def self.build_sitemap_for(base_url, file_path, file_name)
    options = { file_path: file_path, file_name: file_name }
    crawler = new(base_url)
    crawler.generate
    Crawler::SitemapBuilder.new(crawler.graph, options).build
  end

  def initialize(base_uri)
    @base_uri = URI.parse(base_uri)
    @graph = Crawler::Graph.new
    @seen_uri = Set.new
  end

  def generate
    dfs(base_uri)
  end

  def dfs(uri)
    return if seen_it_before?(uri)
    parser = parser(client(uri))
    graph.add_node(page(uri, assets(parser)))
    seen_uri << uri
    parser.hrefs.each do |href|
      dfs(href)
    end
  rescue => e
    warn "Parsing error #{e.inspect}"
  end

  def assets(parser)
    {
      js_assets: parser.js_assets,
      img_assets: parser.img_assets,
      css_assets: parser.css_assets
    }
  end

  def seen_it_before?(uri)
    seen_uri.include?(uri)
  end

  def client(uri)
    Crawler::Client.new(uri)
  end

  def parser(client)
    Crawler::Parser.new(client)
  end

  def page(uri, assets)
    Crawler::Page.new(url: uri, assets: assets)
  end
end
