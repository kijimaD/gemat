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
        sleep 0.1
        pb.increment

        response = fetch(gem)
        next unless response

        gem = Gem.new(response)
        gem.index = idx
        @gems << gem
      end
    end

    private

    def fetch(gem)
      client = HTTPClient.new
      request = client.get(rubygems_api(gem.name))
      begin
        response = JSON.parse(request.body)
      rescue JSON::ParserError
        print "\n#{gem.name} is not found on Rubygems..."
        return
      end
      # puts JSON.pretty_generate(response)
      response
    end

    def rubygems_api(name)
      "https://rubygems.org/api/v1/gems/#{name}.json"
    end
  end
end
