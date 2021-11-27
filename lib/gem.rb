# frozen_string_literal: true

module Gemat
  class Gem
    def initialize(response)
      @response = response
    end

    def name
      @response['name']
    end

    def repo_url
      match = github_url_match([@response.dig('metadata', 'homepage_uri'),
                                @response['homepage_uri'],
                                @response['bug_tracker_uri'],
                                @response['source_code_uri']])
      return if match.nil?

      user = match[1]
      repo = match[2]
      "https://github.com/#{user}/#{repo}"
    end

    private

    def github_url_match(urls)
      reg = %r{https://github.com/([\w\-]+)/([\w\-]+)}
      urls.each do |url|
        return reg.match(url) if reg.match(url)
      end
    end
  end
end
