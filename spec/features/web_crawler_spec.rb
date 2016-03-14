require 'spec_helper'

RSpec.feature 'Web crawler', type: :feature do
  let(:path) { File.dirname(__FILE__) }
  let(:root_page) do
    File.open(File.join(path, "../support/fixtures/index.html"))
  end

  let(:child_page) do
    File.open(File.join(path, "../support/fixtures/security.html"))
  end

  let(:fixture_sitemap) do
    File.read(File.join(path, "../support/fixtures/sitemap.xml"))
  end

  let(:generated_sitemap) do
    File.read(File.join(path, "../../tmp/sitemap.xml"))
  end

  before do
    # stub open uri url to return fixture
    # stub second url to return fixture
    # config set to tmp

    # Crawler.build_sitemap_for("gocardless.com")
  end
  scenario 'writes correct sitemap urls with static assets in xml format to file' do
    expect(fixture_sitemap).to eq(generated_sitemap)
  end
end
