require 'spec_helper'

RSpec.feature 'Web crawler', type: :feature do
  let(:path) { File.dirname(__FILE__) }
  let(:file_path) { File.join(path, "../../tmp/") }

  let(:root_page) do
    File.open(File.join(path, "../support/fixtures/index.html"))
  end

  let(:child_page) do
    File.open(File.join(path, "../support/fixtures/security.html"))
  end

  let(:fixture_sitemap) do
    File.read(File.join(path, "../support/fixtures/sitemap.txt"))
  end

  let(:generated_sitemap) do
    File.read(File.join(file_path, "sitemaps.txt"))
  end

  before do
    allow(OpenURI).to receive(:open_uri).and_return(root_page, child_page)
    Crawler.build_sitemap_for("https://gocardless.com", file_path, "sitemaps.txt")
  end

  after do
    FileUtils.rm([File.join(file_path, "sitemaps.txt")])
  end

  scenario 'writes correct sitemap urls with static assets in txt format to file' do
    expect(fixture_sitemap).to eq(generated_sitemap)
  end
end
