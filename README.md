# RecastAI - Ruby SDK

[![Version](https://badge.fury.io/rb/RecastAI.svg)](https://badge.fury.io/rb/RecastAI)

![logo](https://raw.githubusercontent.com/RecastAI/SDK-ruby/master/misc/logo-inline.png "Recast.AI")

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

client = RecastAI::Client.new(YOUR_TOKEN, YOUR_LANGUAGE)
response = client.text_request(YOUR_TEXT)
#response = client.file_request(File.new(File.join(File.dirname(__FILE__), YOUR_FILE)))

if response.intent.name == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

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
* RecastAI::Intent represents an intent of the response.
* RecastAI::Entity represents an entity found by Recast.AI in your user's input.
* RecastAI::RecastError is the error thrown by the gem.

Don't hesitate to dive into the code, it's commented ;)

### RecastAI::Client

The Recast.AI Client can be instanciated with a token (optional) and a language (optional) and provides the two following methods:

* text_request(text, options = {}) *Performs a text request*
* file_request(file, options = {}) *Performs a voice file request*

On each call to `text_request` or `file_request` your can override either your token or your language by passing a hash of options.

If no language is provided in the request, Recast.AI does the following:

* text_request: the language of the text is detected and is used for processing if your bot has expressions for it, else your bot's primary language is used for processing.
* voice_request: your bot's primary language is used for processing as we do not provide language detection for speech.

If a language is provided, Recast.AI does the following:

* text_request: the language you've given is used for processing if your bot has expressions for it, else your bot's primary language is used.
* voice_request: the language you've given is used for processing if your bot has expressions for it, else your bot's primary language is used

*Accepted options are :token, :language, to override the defaults provided at initialization*

```ruby
require 'recastai'

client = RecastAI::Client.new(YOUR_TOKEN, YOUR LANGUAGE)

# Performs a text request on Recast.AI
response = client.text_request(YOUR_TEXT, { token: YOUR_TOKEN, language: YOUR_LANGUAGE })

if response.intent.name == YOUR_EXPECTED_INTENT
  # Do your code...
end

# Performs a voice file request on Recast.AI
response = client.file_request(File.new(File.join(File.dirname(__FILE__),YOUR_FILE)), { token: YOUR_TOKEN, language: YOUR_LANGUAGE })

if response.intent.name == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

### RecastAI::Response

The Recast.AI Response is generated after a call with the two previous methods and contains the following methods:

* raw(\*) *Returns the raw unparsed response*
* source(\*) *Returns the source sentence Recast.AI processed*
* intents(\*) *Returns all the matched intents*
* intent(\*) *Returns the first matched intent*
* act(\*) *Returns the act of the processed sentence*
* assert?(\*) *Returns whether or not the act is an assertion*
* command?(\*) *Returns whether or not the act is a command*
* wh_query?(\*) *Returns whether or not the act is a wh-query*
* yn_query?(\*) *Returns whether or not the act is a yn-query*
* type(\*) *Returns the type of the processed sentence*
* abbreviation?(\*) *Returns whether or not the sentence is asking for an abbreviation*
* entity?(\*) *Returns whether or not the sentence is asking for an entity*
* description?(\*) *Returns whether or not the sentence is asking for an description*
* human?(\*) *Returns whether or not the sentence is asking for an human*
* location?(\*) *Returns whether or not the sentence is asking for an location*
* number?(\*) *Returns whether or not the sentence is asking for an number*
* negated?(\*) *Returns whether or not the sentence is negated*
* sentiment(\*) *Returns the sentiment of the processed sentence*
* vpositive?(\*) *Returns whether or not the sentiment is very positive*
* positive?(\*) *Returns whether or not the sentiment is positive*
* neutral?(\*) *Returns whether or not the sentiment is neutral*
* negative?(\*) *Returns whether or not the sentiment is negative*
* vnegative?(\*) *Returns whether or not the sentiment is very negative*
* entities(\*) *Returns all the entities*
* get(name) *Returns the first entity matching -name-*
* all(name) *Returns all the entities matching -name-*
* language(\*) *Returns the language of the processed sentence*
* version(\*) *Returns the version of the API*
* timestamp(\*) *Returns the timestamp at the end of the processing*
* status(\*) *Returns the status of the response*

```ruby
response = client.text_request('Give me some recipes with potatoes. And cheese.')

# If the sentence is positive and the first intent matched is 'recipe'...
if response.positive? && response.intent.name == 'recipe'
  # ...get all the entities matching 'ingredient'
  ingredients = response.all('ingredient')

  puts "The request has been filled at #{response.timestamp}"
end
```

### RecastAI::Intent

The Recast.AI Intent is generated by the Recast.AI Response initializer and provides the following methods:

* name(\*) *Returns the name of the intent*
* confidence(\*) *Returns the confidence of detection for this intent*

```ruby
response = client.text_request('Tell me a joke.')

# If the intent is joke with a probability more than 50%
if response.intent.confidence > 0.5 && response.intent.name == 'joke'
  puts "A man enters a coffee, and splash"
else
  puts "What do you want from me?"
end
```

### RecastAI::Entity

The Recast.AI Entity is generated by the Recast.AI Response initializer and provides the following methods:

* name(\*) *Returns the name of the entity*
* raw(\*) *Returns the raw text on which the entity was detected*
* confidence(\*) *Returns the confidence of detection for this entity*

In addition to those default methods, more attributes are generated depending of the nature of the entity, which can be one of the following:

* hex(\*)
* rgb(\*)
* agent(\*)
* tense(\*)
* chrono(\*)
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

```ruby
response = client.text_request('What can I cook with salmon ?')

if response.intent.name == 'recipe'
  # Get the ingredient
  ingredient = response.get('ingredient')

  # Print the reply if the confidence is high enough
  puts "You asked me for a recipe with #{ingredient.value}" if ingredient.confidence > 0.7
end

```

### RecastAI::RecastError

The Recast.AI Error is thrown when receiving an non-200 response from Recast.AI.

As it inherits from ::Exception, it implements the default exception methods.

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
to tsuse, copy, modify, merge, publish, distribute, sublicense, and/or sell
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
