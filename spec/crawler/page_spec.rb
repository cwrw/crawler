require 'spec_helper'

RSpec.describe Crawler::Page do
  subject do
    described_class.new(
      url: URI.parse("https://gocardless.com"),
      assets: {
        js_assets: [URI.parse("www.googletagmanager.com/gtm.js")],
        img_assets: [URI.parse("https://gocardless.com/images/logos/funding.png")],
        css_assets: [URI.parse("https://gocardless.com/bundle/main.css")]
      }
   )
  end

  let(:expected_output) do
    "---------------------------------------\n" \
    "Page: https://gocardless.com\n" \
    "---------------------------------------\n" \
    "assets:\n" \
    "javascript:\n" \
    "www.googletagmanager.com/gtm.js\n" \
    "images:\n" \
    "https://gocardless.com/images/logos/funding.png\n" \
    "stylesheets:\n" \
    "https://gocardless.com/bundle/main.css\n" \
    "\n"
  end

  it "sets the correct string output" do
    expect(subject.to_s).to eq(expected_output)
  end
end
