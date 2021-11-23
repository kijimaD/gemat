# frozen_string_literal: true

require_relative 'dsl'
require 'httpclient'
require 'json'

def main

  dsl = GemfileExporter::Dsl.new

  # p dsl.dependencies.map(&:name)

  base_url = "#{dsl.sources.all_sources[0].remotes[0].to_s}gems/"

  dsl.dependencies.each do |gem|
    # return unless gem == dsl.dependencies.first
    sleep 0.1
    p "start #{gem.name}..."

    url = "https://rubygems.org/api/v1/gems/#{gem.name}.json"

    client = HTTPClient.new
    request =  client.get(url)
    response = JSON.parse(request.body)
    puts JSON.pretty_generate(response)

    reg = %r{https://github.com/([\w\-]+)/([\w\-+])}
    github_gem = github_url(response.dig('metadata', 'homepage_uri')) ||
                 github_url(response.dig('homepage_uri')) ||
                 github_url(response.dig('bug_tracker_uri')) ||
                 github_url(response.dig('source_code_uri'))

    # reg.match(h.to_s)

    # if github_gems[0].class == Hash
    #   github_gems = github_gems[0].values
    # end
    p github_gem
    m = github_gem
    user = m[1]
    repo = m[2]
    p gh_url = "https://github.com/#{user}/#{repo}"

    # p response['source_code_uri']


    # doc = Nokogiri::HTML.parse(web.read)
    # release_url = doc.xpath('//*[@id="code"]')[0][:href]

    # # "https://github.com/rails/rails/tree/v6.1.4.1"

    # reg = %r{https://github.com/(\w+)/(\w+)}
    # m = reg.match(release_url)
    # user = m[1]
    # repo = m[2]

    # gh_url = "https://github.com/#{user}/#{repo}"
    # p gh_url

    # p dsl.git_sources
    # p dsl.groups
    # p dsl.gemspecs

    # rubygemsのURLをどうやって生成しているのか
    # 実際どこでダウンロードしてるのかわからない
    # githubのURLを取るにはスクレイピングしかなさそう

  end
end

def github_url (url)
  reg = %r{https://github.com/([\w\-]+)/([\w\-+])}
  reg.match(url)
end

main()
