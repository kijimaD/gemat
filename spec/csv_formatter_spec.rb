# frozen_string_literal: true

RSpec.describe Gemat::CsvFormatter do
  describe '#to_csv' do
    context 'specify output file' do
      it 'can write to file' do
        gem_mock = instance_double('gem')
        allow(gem_mock).to receive(:name).and_return('gem')
        allow(gem_mock).to receive(:repo_url).and_return('example.com')

        csv_formatter = described_class.new([gem_mock], 'test.csv')
        csv_formatter.to_csv
        expect(File.open('test.csv', 'r', &:read))
          .to eq "gem,Repo URL\ngem,example.com\n"

        File.delete('test.csv')
      end
    end

    context 'not specify output file' do
      it 'can print csv' do
        gem_mock = instance_double('gem')
        allow(gem_mock).to receive(:name).and_return('gem')
        allow(gem_mock).to receive(:repo_url).and_return('example.com')

        csv_formatter = described_class.new([gem_mock])
        csv_formatter.to_csv
      end
    end
  end
end
