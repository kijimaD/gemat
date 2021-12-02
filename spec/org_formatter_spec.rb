# frozen_string_literal: true

RSpec.describe Gemat::OrgFormatter do
  describe 'run' do
    context 'when specify output file' do
      it 'can construct' do
        VCR.use_cassette 'Rubygems' do
          indsl = Gemat::InDsl.new
          fetcher = Gemat::Fetcher.new(indsl)
          fetcher.run

          outdsl = Gemat::OutDsl.create(['index', 'name'])

          formatter = described_class.new(fetcher.gems, outdsl)
        end
      end
    end
  end
end
