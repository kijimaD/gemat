# frozen_string_literal: true

module GemfileExporter
  class GetUrl
    attr_accessor :urls

    def initialize(dsl)
      @dsl = dsl
      @urls = {}
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def run
      @dsl.dependencies.each do |gem|
        # break unless gem == @dsl.dependencies.first

        sleep 0.1
        p "start #{gem.name}..."

        client = HTTPClient.new
        request =  client.get(rubygems_api(gem))
        response = JSON.parse(request.body)
        # puts JSON.pretty_generate(response)

        github_gem = github_url(response.dig('metadata', 'homepage_uri')) ||
                     github_url(response['homepage_uri']) ||
                     github_url(response['bug_tracker_uri']) ||
                     github_url(response['source_code_uri'])
        next if github_gem.nil?

        user = github_gem[1]
        repo = github_gem[2]
        gh_url = "https://github.com/#{user}/#{repo}"
        @urls[gem.name] = gh_url
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def github_url(url)
      reg = %r{https://github.com/([\w\-]+)/([\w\-]+)}
      reg.match(url)
    end

    def rubygems_api(gem)
      "https://rubygems.org/api/v1/gems/#{gem.name}.json"
    end
  end
end
