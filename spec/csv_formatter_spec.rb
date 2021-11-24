# frozen_string_literal: true

require_relative '../lib/csv_formatter'

RSpec.describe GemfileExporter::CsvFormatter do
  after { File.delete('test.csv') }

  describe '#to_csv' do
    it 'can run' do
      url = Object.new
      def url.urls
        ['example.com']
      end
      csv_formatter = described_class.new(url)
      csv_formatter.to_csv
      expect(open('test.csv', 'r', &:read)).to eq "example.com,\n"
    end
  end
end
