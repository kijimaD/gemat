# frozen_string_literal: true

RSpec.describe Gemat::CsvFormatter do
  after { File.delete("#{Gemat::CsvFormatter::DEFAULT_OUTPUT}.csv") }

  describe '#to_csv' do
    it 'can run' do
      url = Object.new
      def url.urls
        { 'gem': 'example.com' }
      end
      csv_formatter = described_class.new(url)
      csv_formatter.to_csv
      expect(File.open("#{Gemat::CsvFormatter::DEFAULT_OUTPUT}.csv", 'r', &:read))
        .to eq "gem,Repo URL\ngem,example.com\n"
    end
  end
end
