# frozen_string_literal: true

require_relative '../lib/dsl'

RSpec.describe Gemat::Dsl do
  describe '#initialize' do
    context 'when valid gemfile' do
      let(:dsl) { described_class.new('spec/fixtures/Gemfile_test') }

      it 'has a dependencies' do
        expect(dsl.dependencies.map(&:name).take(5))
          .to eq %w[rails puma sass-rails webpacker turbolinks]
      end

      it 'has a other attribute' do
        expect(dsl.sources).not_to be nil
        expect(dsl.git_sources).not_to be nil
        expect(dsl.groups).not_to be nil
        expect(dsl.gemspecs).not_to be nil
      end
    end
  end
end
