# frozen_string_literal: true

RSpec.describe Gemat::CsvFormatter do
  after { File.delete('test.csv') }

  describe '#to_csv' do
    it 'can run' do
      url = Object.new
      def url.urls
        { 'gem': 'example.com' }
      end
      csv_formatter = described_class.new(url)
      csv_formatter.to_csv
      expect(open('test.csv', 'r', &:read)).to eq "gem,Repository_URL\ngem,example.com\n"
    end
  end
end
