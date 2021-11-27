# frozen_string_literal: true

module Gemat
  class Fetcher
    attr_accessor :gems

    def initialize(dsl)
      @dsl = dsl
      @gems = []
    end

    # rubocop:disable Metrics/MethodLength
    def run
      pb = ProgressBar.create(total: @dsl.dependencies.length)
      @dsl.dependencies.each do |gem|
        sleep 0.1

        client = HTTPClient.new
        request = client.get(rubygems_api(gem.name))
        begin
          response = JSON.parse(request.body)
        rescue JSON::ParserError
          print "\n#{gem.name} is not found..."
          next
        end
        # puts JSON.pretty_generate(response)

        @gems << Gem.new(response)

        pb.increment
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    def rubygems_api(name)
      "https://rubygems.org/api/v1/gems/#{name}.json"
    end
  end
end
