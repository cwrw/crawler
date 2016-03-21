# Crawler

A web crawler using Depth First Search.

A sitemap is best represented as a graph. Algorithm chosen for now is Depth First Searching.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crawler'
```

And then execute:

  $ bundle

Or install it yourself as:

  $ gem install crawler

## Usage

#####Crawler allows you to crawl a url through the following rake task:

$ rake generate_sitemap``["https://gocardless.com","/path/to/file","file_name"]``

if you leave options empty ``["https://gocardless.com"]`` will default to your desktop (OSx)

## TODO
Handle redirects,
Tests,
Exception handling,
Tidy up base class,
fix algorithm as not performant

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake` to run the tests.

To install this gem onto your local machine, run `gem build crawler.gemspec`, then `gem install ./crawler-0.0.0.gem` with the relevant version number

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cwrw/crawler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Resources
[algorithms](https://franzejr.wordpress.com/2012/08/13/bfs-and-dfs-algorithms/),
[search with nokogiri](http://stackoverflow.com/questions/17035503/dry-search-every-page-of-a-site-with-nokogiri),
[trees in ruby](http://haozeng.github.io/blog/2014/01/05/trees-in-ruby/)
