require 'spec_helper'

RSpec.describe Crawler::Parser do
  let(:base_uri) { URI.parse("https://gocardless.com") }
  let(:client) do
    instance_double(
      Crawler::Client,
      base_uri: base_uri,
      document: document
    )
  end

  subject { described_class.new(client) }

  describe "hrefs" do
    context "urls with no host" do
      let(:document) do
        Nokogiri::HTML("<a href=\"/en-au/\">")
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/en-au/")]
      end

      it "prepends host" do
        expect(subject.hrefs).to eq(expected_uris)
      end

    end

    context "duplicate urls" do
      let(:document) do
        Nokogiri::HTML("<a href=\"/en-au/\"><a href=\"/en-au/\">")
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/en-au/")]
      end

      it "removes duplicates" do
        expect(subject.hrefs).to eq(expected_uris)
      end

    end

    context "urls with different domains" do
      let(:document) do
        Nokogiri::HTML("<a href=\"/en-au/\"><a href=\"http://facebook.com/gocardless\">")
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/en-au/")]
      end

      it "lists urls only under host domain" do
        expect(subject.hrefs).to eq(expected_uris)
      end
    end

    context "urls with path to files" do
      let(:document) do
        Nokogiri::HTML(
          "<a href=\"/en-au/an-image.svg\">" \
          "<a href=\"/fr-be/\">" \
          "<a href=\"/en-au/an-image.png\">"
        )
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/fr-be/")]
      end

      it "ignores any urls to files" do
        expect(subject.hrefs).to eq(expected_uris)
      end
    end

    context "urls with fragments" do
      let(:document) do
        Nokogiri::HTML("<a href=\"/cdn-cgi/l/email-protection#dab\">")
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/cdn-cgi/l/email-protection")]
      end

      it "removes fragments" do
        expect(subject.hrefs).to eq(expected_uris)
      end
    end
  end

  describe "js_assets" do
    context "duplicate urls" do
      let(:document) do
        Nokogiri::HTML(
          "<script src=\"//www.googletagmanager.com/gtm.js\" async>" \
          "<script src=\"//www.googletagmanager.com/gtm.js\" async>"
        )
      end

      let(:expected_uris) do
        [URI.parse("//www.googletagmanager.com/gtm.js")]
      end

      it "removes duplicates" do
        expect(subject.js_assets).to eq(expected_uris)
      end
    end
  end

  describe "img_assets" do
    context "urls with no host" do
      let(:document) do
        Nokogiri::HTML("<img src=\"/images/logos/funding.png\">")
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/images/logos/funding.png")]
      end

      it "prepends host" do
        expect(subject.img_assets).to eq(expected_uris)
      end

    end

    context "duplicate urls" do
      let(:document) do
        Nokogiri::HTML(
          "<img src=\"/images/logos/funding.png\">" \
          "<img src=\"/images/logos/funding.png\">"
        )
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/images/logos/funding.png")]
      end

      it "removes duplicates" do
        expect(subject.img_assets).to eq(expected_uris)
      end
    end

  end

  describe "css_assets" do
    context "urls with no host" do
      let(:document) do
        Nokogiri::HTML("<link rel=\"stylesheet\" href=\"/bundle/main.css\">")
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/bundle/main.css")]
      end

      it "prepends host" do
        expect(subject.css_assets).to eq(expected_uris)
      end
    end

    context "url links with different types" do
      let(:document) do
        Nokogiri::HTML(
          "<link rel=\"stylesheet\" href=\"/bundle/main.css\">" \
          "<link rel=\"alternate\" href=\"/bundle/main.css\">"
        )
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/bundle/main.css")]
      end

      it "only selects stylesheet urls" do
        expect(subject.css_assets).to eq(expected_uris)
      end
    end

    context "duplicate urls" do
      let(:document) do
        Nokogiri::HTML(
          "<link rel=\"stylesheet\" href=\"/bundle/main.css\">" \
          "<link rel=\"stylesheet\" href=\"/bundle/main.css\">"
        )
      end

      let(:expected_uris) do
        [URI.parse("#{base_uri}/bundle/main.css")]
      end

      it "removes duplicates" do
        expect(subject.css_assets).to eq(expected_uris)
      end
    end
  end

  xit "exceptions"
end
