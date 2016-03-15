class Crawler
  class Page
    attr_accessor :url, :js_assets, :img_assets, :css_assets

    def initialize(url:, assets:)
      @url = url
      @js_assets = assets.fetch(:js_assets)
      @img_assets = assets.fetch(:img_assets)
      @css_assets = assets.fetch(:css_assets)
    end

    def to_s # rubocop:disable Metrics/MethodLength
      "---------------------------------------\n" \
      "Page: #{url}\n" \
      "---------------------------------------\n" \
      "assets:\n" \
      "javascript:\n" \
      "#{js_assets.join("\n")}\n" \
      "images:\n" \
      "#{img_assets.join("\n")}\n" \
      "stylesheets:\n" \
      "#{css_assets.join("\n")}\n" \
      "\n"
    end
  end
end
