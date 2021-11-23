# frozen_string_literal: true

module GemfileExporter
  class GetUrl
    def initialize(dsl)
      @dsl = dsl
    end

    def run
      @dsl.dependencies.each do |gem|
        # return unless gem == dsl.dependencies.first
        sleep 0.1
        p "start #{gem.name}..."

        url = "https://rubygems.org/api/v1/gems/#{gem.name}.json"

        client = HTTPClient.new
        request =  client.get(url)
        response = JSON.parse(request.body)
        # puts JSON.pretty_generate(response)

        reg = %r{https://github.com/([\w\-]+)/([\w\-+])}
        github_gem = github_url(response.dig('metadata', 'homepage_uri')) ||
                     github_url(response.dig('homepage_uri')) ||
                     github_url(response.dig('bug_tracker_uri')) ||
                     github_url(response.dig('source_code_uri'))
        next if github_gem.nil?

        user = github_gem[1]
        repo = github_gem[2]
        gh_url = "https://github.com/#{user}/#{repo}"
      end
    end

    def github_url (url)
      reg = %r{https://github.com/([\w\-]+)/([\w\-+])}
      reg.match(url)
    end
  end
end
