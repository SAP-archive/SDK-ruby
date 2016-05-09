# SDK-ruby

![logo](https://raw.githubusercontent.com/RecastAI/SDK-ruby/master/misc/logo-inline.png "Recast.AI")

[![Version](https://badge.fury.io/rb/RecastAI.svg)](https://badge.fury.io/rb/RecastAI)

Recast.AI official SDK in Ruby.


## Synospis

This gem is a pure Ruby interface to the [Recast.AI](https://recast.ai) API. It allows you to make requests to your bots.


## Requirements

* Ruby 2.2+


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
gem install RecastAI-*.gem
```


## Usage

### Gem

```ruby
require 'recastai'

client = RecastAI::Client.new(YOUR_TOKEN)
response = client.text_request(YOUR_TEXT)
#response = client.file_request(File.new(File.join(File.dirname(__FILE__), YOUR_FILE)))

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
./bin/file YOUR_TOKEN YOUR_VOICE_FILE
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

* text_request(text, options = {}) *Performs a text request*
* file_request(file, options = {}) *Performs a voice file request*

*Accepted options are :token, to override the default token provided at initialization*

### RecastAI::Response

The Recast.AI Response is generated after a call with the two previous methods and contains the following methods:

* raw(\*) *Returns the raw unparsed response*
* source(\*) *Returns the source sentence Recast.AI processed*
* intents(\*) *Returns all the matched intents*
* intent(\*) *Returns the first matched intent*
* sentences(\*) *Returns all the detected sentences*
* sentence(\*) *Returns the first detected sentence*
* get(name) *Returns the first entity matching -name-*
* all(name) *Returns all the entities matching -name-*
* version(\*) *Returns the version of the JSON*
* timestamp(\*) *Returns the timestamp at the end of the processing*
* status(\*) *Returns the status of the response*

### RecastAI::Sentence

The Recast.AI Sentence is generated by the Recast.AI Response initializer and provides the following methods:

* source(\*) *Returns the source of the sentence*
* type(\*) *Returns the type of the sentence*
* action(\*) *Returns the action of the sentence*
* agent(\*) *Returns the agent of the sentence*
* polarity(\*) *Returns the polarity (negation or not) of the sentence*
* entities(\*) *Returns all the entities detected in the sentence*

### RecastAI::Entity

The Recast.AI Entity is generated by the Recast.AI Sentence initializer and provides the following method:

* name(\*) *Returns the name of the entity*
* raw(\*) *Returns the raw text on which the entity was detected*

In addition to this method, more attributes are generated depending of the nature of the entity, which can be one of the following:

* hex(\*)
* value(\*)
* deg(\*)
* formated(\*)
* lng(\*)
* lat(\*)
* unit(\*)
* code(\*)
* person(\*)
* number(\*)
* gender(\*)
* next(\*)
* grain(\*)
* order(\*)

### RecastAI::RecastError

The Recast.AI Error is thrown when receiving an non-200 response from Recast.AI.

As it inherits from ::Exception, it implements the default expection methods.

## More

You can view the whole API reference at [man.recast.ai](https://man.recast.ai).


## Author

Paul Renvoisé, paul.renvoise@recast.ai, [@paulrenvoise](https://twitter.com/paulrenvoise)

You can follow us on Twitter at [@recastai](https://twitter.com/recastai) for updates and releases.


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
