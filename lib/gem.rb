# frozen_string_literal: true

module Gemat
  class Gem
    attr_accessor :index, :rubygems, :github

    def initialize(rubygems)
      @rubygems = rubygems
      @index = 0
    end

    def repo_uri
      match = github_uri_match([@rubygems.dig('metadata', 'homepage_uri'),
                                @rubygems['homepage_uri'],
                                @rubygems['bug_tracker_uri'],
                                @rubygems['source_code_uri']])
      return if match.nil?

      user = match[1]
      repo = match[2]
      "https://github.com/#{user}/#{repo}"
    end

    private

    def github_uri_match(uris)
      reg = %r{github.com/([\w\-]+)/([\w\-]+)}
      uris.each do |uri|
        return reg.match(uri) if reg.match(uri)
      end
    end
  end
end
