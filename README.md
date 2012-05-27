# Eager

Simple eager-loading for ruby.

*Note: Eager is not yet available on rubygems.org.*

## Usage

```ruby
module MyGem
  extend Eager

  register_autoloads(self) do
    autoload :Util, 'util'
  end
end
```

By default, Eager will serve as a pass-thru to autoload on your class. Eager
will also add an `eager_load!` method to your class as a means to require all
defined autoloads for thread-safety.

## Inspiration

Eager is derived from the [AWS SDK for Ruby](https://github.com/amazonwebservices/aws-sdk-for-ruby).

## Contributing

Pull requests welcome: fork, make a topic branch, commit (squash when possible) *with tests* and I'll happily consider.

## Copyright

Copyright (c) 2012 Steve Agalloco. See [LICENSE](https://github.com/spagalloco/eager/blob/master/LICENSE.md) for detail