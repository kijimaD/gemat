# frozen_string_literal: true

module Gemat
  class Fetcher
    def initialize(dsl)
      @dsl = dsl
      @urls = {}
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def run
      pb = ProgressBar.create(total: @dsl.dependencies.length)
      @dsl.dependencies.each do |gem|
        sleep 0.1

        client = HTTPClient.new
        request = client.get(rubygems_api(gem))
        begin
          response = JSON.parse(request.body)
        rescue JSON::ParserError
          print "not found\n"
          next
        end
        # puts JSON.pretty_generate(response)

        match = github_url_match(response.dig('metadata', 'homepage_uri')) ||
                github_url_match(response['homepage_uri']) ||
                github_url_match(response['bug_tracker_uri']) ||
                github_url_match(response['source_code_uri'])
        next if match.nil?

        user = match[1]
        repo = match[2]
        gh_url = "https://github.com/#{user}/#{repo}"
        @urls[gem.name] = gh_url

        pb.increment
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def github_url_match(url)
      reg = %r{https://github.com/([\w\-]+)/([\w\-]+)}
      reg.match(url)
    end

    def rubygems_api(gem)
      "https://rubygems.org/api/v1/gems/#{gem.name}.json"
    end

    def urls
      @urls.sort.to_h
    end
  end
end