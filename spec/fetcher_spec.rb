# frozen_string_literal: true

RSpec.describe Gemat::Fetcher do
  describe '#run' do
    it 'set @urls' do
      dsl_mock = instance_double('dsl')
      dependencies_mock = instance_double('dependencies')
      allow(dsl_mock).to receive(:dependencies).and_return([dependencies_mock])
      allow(dependencies_mock).to receive(:name).and_return('rails')

      dsl = described_class.new(dsl_mock)
      dsl.run
      expect(dsl.gems.first).to have_attributes('name': 'rails',
                                                'repo_url': 'https://github.com/rails/rails')
    end
  end
end
