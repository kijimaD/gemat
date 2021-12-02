# frozen_string_literal: true

RSpec.describe Gemat::OrgFormatter do
  describe 'run' do
    context 'when specify output file' do
      it 'can write to file' do
        VCR.use_cassette 'Rubygems' do
          indsl = Gemat::InDsl.new
          fetcher = Gemat::Fetcher.new(indsl)
          fetcher.run

          outdsl = Gemat::OutDsl.create(['index', 'name'])

          formatter = described_class.new(fetcher.gems, outdsl)
          # gem_mock = instance_double('gem')
          # allow(gem_mock).to receive(:name).and_return('gem')
          # allow(gem_mock).to receive(:repo_url).and_return('example.com')

          # csv_formatter = described_class.new([gem_mock], output: 'test.csv')
          # csv_formatter.to_csv
          # expect(File.open('test.csv', 'r', &:read))
          #   .to eq "name,Repo URL\ngem,example.com\n"

          # File.delete('test.csv')
        end
      end
    end
  end
end
