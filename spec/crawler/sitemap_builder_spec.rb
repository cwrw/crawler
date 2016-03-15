require 'spec_helper'

RSpec.describe Crawler::SitemapBuilder do
  let(:full_path) { File.join(file_path, "sitemaps.txt") }
  let(:file_path) { File.join(File.dirname(__FILE__), "../../tmp/") }
  let(:graph) { Crawler::Graph.new }
  let(:page_1) do
    Crawler::Page.new(
      url: URI.parse("https://gocardless.com"),
      assets: {
        js_assets: [URI.parse("www.googletagmanager.com/gtm.js")],
        img_assets: [URI.parse("https://gocardless.com/images/logos/funding.png")],
        css_assets: [URI.parse("https://gocardless.com/bundle/main.css")]
      }
    )
  end

  let(:page_2) do
    Crawler::Page.new(
      url: URI.parse("https://gocardless.com/security"),
      assets: {
        js_assets: [URI.parse("www.googletagmanager.com/gtm.js")],
        img_assets: [URI.parse("https://gocardless.com/security/images/logos/funding.png")],
        css_assets: [URI.parse("https://gocardless.com/security/bundle/main.css")]
      }
    )
  end

  let(:options) { { file_path: file_path, file_name: "sitemaps.txt" } }

  let(:expected_output) do
    "Number of pages: 2\n" \
    "---------------------------------------\n" \
    "Page: https://gocardless.com\n" \
    "---------------------------------------\n" \
    "assets:\n" \
    "javascript:\n" \
    "www.googletagmanager.com/gtm.js\n" \
    "images:\n" \
    "https://gocardless.com/images/logos/funding.png\n" \
    "stylesheets:\n" \
    "https://gocardless.com/bundle/main.css\n\n" \
    "---------------------------------------\n" \
    "Page: https://gocardless.com/security\n" \
    "---------------------------------------\n" \
    "assets:\n" \
    "javascript:\n" \
    "www.googletagmanager.com/gtm.js\n" \
    "images:\n" \
    "https://gocardless.com/security/images/logos/funding.png\n" \
    "stylesheets:\n" \
    "https://gocardless.com/security/bundle/main.css\n\n" \
  end

  subject { described_class.new(graph, options) }

  before do
    graph.add_node(page_1)
    graph.add_node(page_2)
    subject.build
  end

  after do
    FileUtils.rm([full_path])
  end

  it "creates sitemaps file with correct urls" do
    expect(File.read(full_path)).to eq(expected_output)
  end

  xit "exceptions"
end
