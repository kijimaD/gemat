# frozen_string_literal: true

RSpec.describe Gemat::OutDsl do
  describe '#initialize' do
    it 'can run' do
      VCR.use_cassette 'Rubygems' do
        dsl = Gemat::InDsl.new
        fetcher = Gemat::Fetcher.new(dsl)
        fetcher.run
        gem = fetcher.gems.first

        dsl = Gemat::OutDsl.new('name')
        expect(dsl.call(gem)).to eq('httpclient')
      end
    end
  end
end
