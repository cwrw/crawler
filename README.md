# Crawler

A web crawler using Depth First Search.

A sitemap is best represented as a hierarchical tree, with the root node being the home page, and the subtrees the directories.

Algorithm chosen for now is Depth First Searching to be able to get to all the nodes.

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

#####Crawler allows you to enter a url and config through a rake task:

$ rake generate_sitemap ["https://gocardless.com", {file_path: "/path/to/file", file_name: "sitemaps.txt"}]

## TODO

Tests
Exception handling
Tidy up base class
fix algorithm as not performant

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake` to run the tests.

To install this gem onto your local machine, run `gem build catz.gemspec`, then `gem install ./catz-0.0.0.gem` with the relevant version number

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cwrw/cats. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Resources
[algorithms](https://franzejr.wordpress.com/2012/08/13/bfs-and-dfs-algorithms/)
[search with nokogiri](http://stackoverflow.com/questions/17035503/dry-search-every-page-of-a-site-with-nokogiri)
[trees in ruby](http://haozeng.github.io/blog/2014/01/05/trees-in-ruby/)
