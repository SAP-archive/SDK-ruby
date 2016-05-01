# SDK-ruby

Recast.AI official SDK in Ruby.


## Synospis

This gem is a pure Ruby interface to the [Recast.AI](https://recast.ai) API. It allows you to make requests to your bots.


## Installation

### Via Gemfile

From [rubygems.org](https://rubygems.org/):

```bash
gem 'RecastAI'
```

From [github.com](https://github.com/):

```bash
gem 'RecastAI', github: 'RecastAI/SDK-ruby'
```

### Via Terminal

From [rubygems.org](https://rubygems.org/):

```bash
gem install 'RecastAI'
```

From [github.com](https://github.com/):

```bash
git clone https://github.com/RecastAI/SDK-ruby
gem build recastai.gemspec
gem install recastai-*.gem
```


## Usage

### Gem

```ruby
require 'RecastAI'

client = RecastAI::Client.new(YOUR_TOKEN)
response = client.text_request(YOUR_TEXT)

if response.intent == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

```ruby
require 'RecastAI'

client = RecastAI::Client.new(YOUR_TOKEN)
response = client.file_request(File.new(File.join(File.dirname(__FILE__), YOUR_FILE)))

if response.intent == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

You can find more examples in the `misc/` folder.

### CLI

```bash
./bin/text YOUR_TOKEN YOUR_TEXT
# => Recast.AI's response
```

```bash
./bin/file YOUR_VOICE_FILE YOUR_TEXT
# => Recast.AI's response
```

## Specs

### Classes

This gem contains 5 main classes, as follows:

* RecastAI::Client is the client allowing you to make requests.
* RecastAI::Response contains the response from [Recast.AI](https://recast.ai).
* RecastAI::Sentence represents a sentence of the response.
* RecastAI::Entity represents an entity found by Recast.AI in your user's input.
* RecastAI::RecastError is the error thrown by the gem.

Don't hesitate to dive into the code, it's commented ;)

### RecastAI::Client

The Recast.AI Client can be instanciated with a token and provides the two following methods:

* text_request(text, options = {})
* file_request(file, options = {})

*Accepted options are :token, to override the default token provided at initialization*

## License

Copyright (c) [2016] [Recast.AI](https://recast.ai)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
