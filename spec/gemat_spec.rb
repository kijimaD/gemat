# frozen_string_literal: true

RSpec.describe Gemat do
  it 'has a version number' do
    expect(Gemat::VERSION).not_to be nil
  end

  describe 'csv' do
    it 'can run' do
      Gemat::Cli.new.csv
    end
  end

  describe 'md' do
    it 'can run' do
      Gemat::Cli.new.md
    end
  end
end
