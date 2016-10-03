# Recast.AI - Ruby SDK

[![Version](https://badge.fury.io/rb/RecastAI.svg)](https://badge.fury.io/rb/RecastAI)

![logo](https://raw.githubusercontent.com/RecastAI/SDK-ruby/master/misc/logo-inline.png "Recast.AI")

Recast.AI official SDK in Ruby.


## Synospis

This gem is a pure Ruby interface to the [Recast.AI](https://recast.ai) API. It allows you to make requests to your bots.


## Requirements

* Ruby 2.2+


## Installation

```bash
gem install 'RecastAI'
```

## Usage

```ruby
require 'recastai'

client = RecastAI::Client.new(YOUR_TOKEN, YOUR_LANGUAGE)

# text request
response = client.text_request(YOUR_TEXT)
if response.intent.slug == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

## Specs

### Classes

This gem contains 5 main classes, as follows:

* RecastAI::Client is the client allowing you to make requests.
* RecastAI::Response contains the response from [Recast.AI](https://recast.ai).
* RecastAI::Intent represents an intent of the response.
* RecastAI::Entity represents an entity found by Recast.AI in your user's input.
* RecastAI::RecastError is the error thrown by the gem.

Don't hesitate to dive into the code, it's commented :)

## RecastAI::Client

The Client can be instanciated with a token and a language (both optional)

```ruby
client = RecastAI::Client.new(YOUR_TOKEN, YOUR_LANGUAGE)
```

__Your tokens__

[token]: https://github.com/RecastAI/SDK-Ruby/blob/master/misc/recast-ai-tokens.png "Tokens"

![alt text][token]

*Copy paste your request access token from your bot's settings*

__Your language__

```ruby
client = RecastAI::Client.new(YOUR_TOKEN, 'en')
```

*The language is a lowercase 639-1 isocode.*

## Text Request

text_request(text, options = {})

If you pass a token or a language in the options parameter, it will override your default client language or token

```ruby
response = client.text_request(YOUR_TEXT)

if response.intent.slug == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

```ruby
# With optional parameters
response = client.text_request(YOUR_TEXT, { token: YOUR_TOKEN, language: YOUR_LANGUAGE })
```

__If a language is provided:__ the language you've given is used for processing if your bot has expressions for it, else your bot's primary language is used.

__If no language is provided:__ the language of the text is detected and is used for processing if your bot has expressions for it, else your bot's primary language is used for processing.

## File request

file_request(file, options = {})

If you pass a token or a language in the option parameter, it will override your default client language or token.

__file format: .wav__
```ruby
response = client.file_request(File.new(File.join(File.dirname(__FILE__),YOUR_FILE)))

if response.intent.slug == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

```ruby
# with optional parameters
response = client.file_request(File.new(File.join(File.dirname(__FILE__),YOUR_FILE)), { token: YOUR_TOKEN, language: YOUR_LANGUAGE })
```

__If a language is provided:__ the language you've given is used for processing if your bot has expressions for it, else your bot's primary language is used

__If no language is provided:__ your bot's primary language is used for processing as we do not provide language detection for speech.


## RecastAI::Response

The Response is generated after a call to either file_request or text_request.

### Get the first detected intent

| Method        | Params | Return                    |
| ------------- |:------:| :-------------------------|
| intent()      |        | the first detected intent |

```ruby
response = client.text_request(YOUR_TEXT)

if response.intent.slug == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

### Get the first entity matching name

| Method     | Params        | Return                   |
| ---------- |:-------------:| :------------------------|
| get(name)  | name: String  | the first Entity matched |

```ruby
response = client.text_request(YOUR_TEXT)

location = response.get('location')
```

### Get all entities matching name

| Method     | Params        | Return                   |
| ---------- |:-------------:| :------------------------|
| all(name)  | name: String  | all the Entities matched |

```ruby
response = client.text_request(YOUR_TEXT)

locations = response.all('location')
```



### Act helpers

| Method        | Params | Return                                                 |
| ------------- |:------:| :----------------------------------------------------- |
| assert?       |        | Bool: whether or not the sentence is an assertion      |
| command?      |        | Bool: whether or not the sentence is a command         |
| wh\_query?    |        | Bool: whether or not the sentence is a question        |
| yn\_query?    |        | Bool: whether or not the sentence is a query           |

### Type helpers

| Method        | Params | Return                                                 |
| ------------- |:------:| :----------------------------------------------------- |
| abbreviation? |        | Bool: is the answer of the sentence an abbreviation?   |
| entity?       |        | Bool: is the answer of the sentence an entity?         |
| description?  |        | Bool: is the answer of the sentence an description?    |
| human?        |        | Bool: is the answer of the sentence an human?          |
| location?     |        | Bool: is the answer of the sentence a location?        |
| number?       |        | Bool: is the answer of the sentence an number?         |

### Sentiment helpers

| Method        | Params | Return                                                 |
| ------------- |:------:| :----------------------------------------------------- |
| vpositive?    |        | Bool: is the sentence very positive?                   |
| positive?     |        | Bool: is the sentence positive?                        |
| neutral?      |        | Bool: is the sentence neutral?                         |
| negative?     |        | Bool: is the sentence negative?                        |
| vnegative?    |        | Bool: is the sentence very negative?                   |

### Getters

Each of the following methods corresponds to a Response attribute

| Method        | Params | Return                                              |
| ------------- |:------:| :---------------------------------------------------|
| raw()         |        | String: the raw unparsed json response              |
| uuid()        |        | String: the universal unique id of the request      |
| source()      |        | String: the user input                              |
| intents()     |        | Array[Intent]: all the matched intents              |
| act()         |        | String: the act of the sentence                     |
| type()        |        | String: the type of the sentence                    |
| sentiment()   |        | String: the sentiment of the sentence               |
| entities()    |        | Array[Entity]: all the detected entities            |
| language()    |        | String: the language of the sentence                |
| version()     |        | String: the version of the json                     |
| timestamp()   |        | String: the timestamp at the end of the processing  |
| status()      |        | String: the status of the response                  |

## RecastAI::Intent

Each of the following methods corresponds to an Intent attribute

| Attributes  | Description                                                   |
| ----------- |:--------------------------------------------------------------|
| slug        | String: the slug of the intent                                |
| confidence  | Float: the unparsed json value of the intent                  |

## RecastAI::Entity

Each of the following methods corresponds to an Entity attribute

| Attributes  | Description                                                   |
| ----------- |:--------------------------------------------------------------|
| name        | String: the name of the entity                                |
| raw         | String: the raw value extracted from the sentence             |
| confidence  | Float: the detection score between 0 and 1 excluded           |

In addition to those methods, more attributes are generated depending of the nature of the entity.
The full list can be found there: [man.recast.ai](https://man.recast.ai/#list-of-entities)

```ruby
response = client.text_request(YOUR_TEXT)

location = response.get('location')

puts location.raw
puts location.name
```

## RecastAI::RecastError

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
