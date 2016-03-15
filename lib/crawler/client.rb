class Crawler
  class Client
    attr_reader :base_uri

    def initialize(base_url)
      @base_uri = URI.parse(base_url)
    end

    def document
      Nokogiri::HTML(open(base_uri))
    rescue OpenURI::HTTPError => error
      warn "Failed to retreive: #{base_uri} with error: #{error.inspect}"
    end
  end
end
