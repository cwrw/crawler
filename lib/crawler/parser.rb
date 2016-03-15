class Crawler
  class Parser
    attr_reader :base_uri, :document

    FILES = %w(png jpeg jpg gif svg txt js css)

    def initialize(client)
      @base_uri = client.base_uri
      @document = client.document
    end

    def hrefs
      @_hrefs ||= (
        links = document.css('a[href]').map { |a| a['href'] }
        uris = join_base_uri(links)
        select_host_uris!(uris)
        reject_uri_paths!(uris)
        remove_fragments!(uris)
      )
    end

    def js_assets
      @_javascript_assets = (
        links = document.css('script[src]').map { |script| script['src'] }
        links.map { |link| URI.parse(link) }.uniq
      )
    end

    def img_assets
      @_image_assets = (
        links = document.css('img[src]').map { |img| img['src'] }
        join_base_uri(links)
      )
    end

    def css_assets
      @_stylesheet_assets = (
        links = document
          .css('link')
          .select { |node| node.attributes["rel"].value == "stylesheet" }
          .map { |link| link['href'] }
        join_base_uri(links)
      )
    end

    private

    def join_base_uri(paths)
      paths.map { |path| URI.join(base_uri, path) rescue nil }.uniq.compact
    end

    def select_host_uris!(uris)
      uris.select! { |uri| uri.host == base_uri.host }
    end

    def reject_uri_paths!(uris)
      uris.reject! { |uri| FILES.any? { |ext| uri.path.end_with?(".#{ext}") } }
    end

    def remove_fragments!(uris)
      uris.each { |uri| uri.fragment = nil }
    end
  end
end
