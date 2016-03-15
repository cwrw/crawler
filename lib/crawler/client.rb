class Crawler
  class Client
    attr_reader :base_uri

    def initialize(base_uri)
      @base_uri = base_uri
    end

    def document
      Nokogiri::HTML(open(base_uri))
    rescue OpenURI::HTTPError => error
      warn "Failed to retreive: #{base_uri} with error: #{error.backtrace}"
    end
  end
end
