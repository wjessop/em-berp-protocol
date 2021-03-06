[![Build Status](https://secure.travis-ci.org/wjessop/em-berp-protocol.png?branch=master)](https://travis-ci.org/wjessop/em-berp-protocol)

# EventMachine::Protocols::BerpProtocol

EventMachine connection protocol for sending and receiving BERP messages.

## Installation

Add this line to your application's Gemfile:

    gem 'em-berp-protocol'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install em-berp-protocol

## Usage

``` ruby
require 'em-berp-protocol'

module RubyServer
  include EventMachine::Protocols::BerpProtocol

  def receive_object(obj)
    send_object({'Oh yeah' => obj})
  end

  # Optional - specify a receive_error method to get notifications of problems parsing bert data
  # When this happens em-berp-protocol closes the client connection
  def receive_error(error_string)
  	puts error
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Will Jessop, @will_j on Twitter, will@willj.net

Let me know if you have any problems or need help getting it working.