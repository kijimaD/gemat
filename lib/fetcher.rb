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
      @dsl.dependencies.each_with_index do |dependency, idx|
        pb.increment

        response = fetch_rubygems(dependency)
        next unless response

        create_gem(response, idx)
        sleep 0.2
      end
    end

    private

    def create_gem(rubygems, idx)
      gem = Gem.new(rubygems)
      gem.github = fetch_github(gem)
      gem.index = idx
      @gems << gem
    end

    def fetch_rubygems(gem)
      fetch(rubygems_api(gem.name))
    end

    def fetch_github(gem, uri = nil)
      uri ||= gem.repo_uri.gsub(/github.com/, 'api.github.com/repos')
      response = fetch(uri)
      response = fetch_github(gem, response['url']) if response['message'] == 'Moved Permanently'
      response
    end

    # rubocop:disable Metrics/MethodLength
    def fetch(uri)
      failed = []
      client = HTTPClient.new
      request = client.get(uri)
      begin
        response = JSON.parse(request.body)
      rescue JSON::ParserError
        failed << gem.name
        return
      end

      print "#{failed.join(',')}: failed fetcing info." unless failed.empty?
      response
    end
    # rubocop:enable Metrics/MethodLength

    def rubygems_api(name)
      "https://rubygems.org/api/v1/gems/#{name}.json"
    end
  end
end
