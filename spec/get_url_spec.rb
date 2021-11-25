# frozen_string_literal: true

require_relative '../lib/get_url'

RSpec.describe Gemat::GetUrl do
  describe '#run' do
    it 'set @urls' do
      dsl_mock = instance_double('dsl')
      dependencies_mock = instance_double('dependencies')
      allow(dsl_mock).to receive(:dependencies).and_return([dependencies_mock])
      allow(dependencies_mock).to receive(:name).and_return('rails')

      dsl = Gemat::GetUrl.new(dsl_mock)
      dsl.run
      expect(dsl.urls).to eq({ 'rails' => 'https://github.com/rails/rails' })
    end
  end
end
