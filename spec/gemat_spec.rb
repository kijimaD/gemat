# frozen_string_literal: true

RSpec.describe Gemat do
  it 'has a version number' do
    expect(Gemat::VERSION).not_to be nil
  end

  describe 'gemat' do
    it 'can run' do
      dsl = Gemat::Dsl.new('spec/fixtures/Gemfile_test')
      url = Gemat::GetUrl.new(dsl)
      url.run
      Gemat::CsvFormatter.new(url).to_csv
    end
  end
end
