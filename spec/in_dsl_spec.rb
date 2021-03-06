# frozen_string_literal: true

RSpec.describe Gemat::InDsl do
  describe '#initialize' do
    context 'when specify valid Gemfile' do
      let(:dsl) { described_class.new('spec/fixtures/Gemfile_test') }

      it 'has a dependencies' do
        expect(dsl.dependencies.map(&:name).take(5))
          .to eq %w[rails ranked-model pg byebug web-console]
      end

      it 'has a other attribute' do
        expect(dsl.sources).not_to be nil
        expect(dsl.git_sources).not_to be nil
        expect(dsl.groups).not_to be nil
      end
    end

    context 'when not specify Gemfile' do
      it 'auto detect Gemfile' do
        dsl = described_class.new
        expect(dsl.gemfiles.to_s).to include('Gemfile')
      end
    end
  end
end
