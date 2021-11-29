# frozen_string_literal: true

module Gemat
  class Fetcher
    attr_accessor :gems

    def initialize(dsl)
      @dsl = dsl
      @gems = []
    end

    def run
      pb = ProgressBar.create(total: @dsl.dependencies.length)
      @dsl.dependencies.each_with_index do |gem, idx|
        pb.increment

        response = fetch(gem)
        sleep 0.2
        next unless response

        gem = Gem.new(response)
        gem.index = idx
        @gems << gem
      end
    end

    private

    # rubocop:disable Metrics/MethodLength
    def fetch(gem)
      failed = []

      client = HTTPClient.new
      request = client.get(rubygems_api(gem.name))
      begin
        response = JSON.parse(request.body)
      rescue JSON::ParserError
        failed << gem.name
        return
      end

      print "#{failed.join(',')}: failed fetcing gem info." unless failed.empty?
      response
    end
    # rubocop:enable Metrics/MethodLength

    def rubygems_api(name)
      "https://rubygems.org/api/v1/gems/#{name}.json"
    end
  end
end
