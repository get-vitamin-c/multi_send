# MultiSend

MultiSend makes it easier to do some advanced metaprogramming with Ruby.

Ruby takes after Smalltalk's message sending paradigm.
This is a powerful abstraction, and allows for some pretty awesome metaprogramming.
By default, `Object#send` only allows you to send one message...
MultiSend provides a way to extend that, making it even more powerful.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multi_send'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_send

## Usage

### `MultiSend.array(object, *messages)`

This works much like `Object#send`.
MultiSend will send each item in order to the object, so the following lines are equivalent:

```ruby
(5 + 5).even?.to_s
5.send("+", 5).send(:even?).send(:to_s)
MultiSend.array(5, ["+", 5], :even?, :to_s)
# with refinements/monkey patches:
5.send_array(["+", 5], :even?, :to_s)
```

### `MultiSend.hash(object, **messages)`

This sends the `**messages` hash to object. Each key is a message, and the key's value is the argument.
If the key's value is an array, then it works with all of them.
So the following is equivalent:

```ruby
"hello".split("").include?("h")
"hello".send(:split, "").send(:include?, "h")
MultiSend.hash("hello", split: "", include?: "h")
# with refinements,
"hello".send_hash(split: "", include?: "h")
```

### `MultiSend.do(object, [*messages|**messages])`

This one determines whether or not the `messages` parameter is a hash or an array, and delegates to the correct method above.

### Refinements/Monkey Patches

You can enable the refinements via `using MultiSend`.
If you want them available application-wide, then `require 'multi_send/object'` to enable the monkey patches.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/get-vitamin-c/multi_send/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
