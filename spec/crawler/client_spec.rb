require 'spec_helper'

RSpec.describe Crawler::Client do
  subject { described_class.new(URI.parse("https://gocardless.com")) }

  context "valid url" do
    before do
      allow(OpenURI).to receive(:open_uri).and_return("my_document")
    end

    it "retrieves html document from url" do
      expect(subject.document.text).to eq("my_document")
    end
  end

  context "exceptions" do
    before do
      allow(OpenURI).to receive(:open_uri).and_raise(OpenURI::HTTPError.new("BOOM!", "io"))
    end

    it "fails silently with a warning" do
      expect(subject).to receive(:warn).with(%r{Failed to retreive: https:\/\/gocardless.com})
      subject.document
    end
  end
end
