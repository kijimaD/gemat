[![Gem Version](https://badge.fury.io/rb/gemat.svg)](https://badge.fury.io/rb/gemat)
[![Check](https://github.com/kijimaD/gemat/actions/workflows/ruby.yml/badge.svg)](https://github.com/kijimaD/gemat/actions/workflows/ruby.yml)

# Gemat

Gemat is a Ruby gem for curating and exporing Gemfile to several formats!

```shell
$ gemat md

| index | name | repo_uri | documentation_uri |
| ---- | ---- | ---- | ---- |
| 0 | httpclient | https://github.com/nahi/httpclient | https://www.rubydoc.info/gems/httpclient/2.8.3 |
| 1 | rake | https://github.com/ruby/rake | https://ruby.github.io/rake |
| 2 | ruby-progressbar | https://github.com/jfelchner/ruby-progressbar | https://github.com/jfelchner/ruby-progressbar/tree/releases/v1.11.0 |
| 3 | thor | https://github.com/erikhuda/thor | http://whatisthor.com/ |
```

| index | name | repo_uri | documentation_uri |
| ---- | ---- | ---- | ---- |
| 0 | httpclient | https://github.com/nahi/httpclient | https://www.rubydoc.info/gems/httpclient/2.8.3 |
| 1 | rake | https://github.com/ruby/rake | https://ruby.github.io/rake |
| 2 | ruby-progressbar | https://github.com/jfelchner/ruby-progressbar | https://github.com/jfelchner/ruby-progressbar/tree/releases/v1.11.0 |
| 3 | thor | https://github.com/erikhuda/thor | http://whatisthor.com/ |

## Installation

```ruby
gem gemat
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gemat

## Usage

```shell
# at your bundled project...

$ gemat csv # export to CSV
$ gemat md  # export to markdown

# optional arguments
$ gemat csv --input ~/path/to/Gemfile # specify gemfile
$ gemat csv --output test.csv         # specify writing file
$ gemat csv --columns index repo_uri name documentation_uri gem_uri version authors # specify printing column
$ gemat md --all t # select all column
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kijimaD/gemat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kijimaD/gemat/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Gemat project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kijimaD/gemat/blob/master/CODE_OF_CONDUCT.md).
