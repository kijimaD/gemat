# frozen_string_literal: true

RSpec.describe Gemat::Fetcher do
  describe '#run' do
    it 'set @gems' do
      VCR.use_cassette 'Rubygems' do
        dsl_mock = instance_double('dsl')
        dependencies_mock = instance_double('dependencies')
        allow(dsl_mock).to receive(:dependencies).and_return([dependencies_mock])
        allow(dependencies_mock).to receive(:name).and_return('vcr')

        dsl = described_class.new(dsl_mock)
        dsl.run
        expect(dsl.gems.first).to have_attributes('repo_uri': 'https://github.com/vcr/vcr')
      end
    end
  end
end
