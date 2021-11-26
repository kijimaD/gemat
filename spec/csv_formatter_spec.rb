# frozen_string_literal: true

RSpec.describe Gemat::CsvFormatter do
  describe '#to_csv' do
    context 'specify output file' do
      it 'can write to file' do
        url_mock = instance_double('url')
        allow(url_mock).to receive(:urls).and_return({ 'gem': 'example.com' })

        csv_formatter = described_class.new(url_mock, 'test.csv')
        csv_formatter.to_csv
        expect(File.open('test.csv', 'r', &:read))
          .to eq "gem,Repo URL\ngem,example.com\n"

        File.delete('test.csv')
      end
    end

    context 'not specify output file' do
      it 'can print csv' do
        url_mock = instance_double('url')
        allow(url_mock).to receive(:urls).and_return({ 'gem': 'example.com' })

        csv_formatter = described_class.new(url_mock)
        csv_formatter.to_csv
      end
    end
  end
end
