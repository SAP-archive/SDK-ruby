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
responseFromText = client.text_request(YOUR_TEXT)

# file request
responseFromFile = client.file_request(File.new(File.join(File.dirname(__FILE__), YOUR_FILE)))

if responseFromText.intent == YOUR_EXPECTED_INTENT
  # Do your code...
end
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

## RecastAI::Client

The Client can be instanciated with a token and a language (both optional)

```ruby
client = RecastAI::Client.new(YOUR_TOKEN, YOUR_LANGUAGE)
```

#### Your tokens


*Copy paste your request access token in your bot's settings*

#### Your language

```ruby
client = RecastAI::Client.new(YOUR_TOKEN, 'en')
```

*The language is a lowercase isocode.*

### Text Request

text_request(text, options = {})

If you pass a token or a language in the options parameter, it will override your default client language or token

```ruby
response = client.text_request(YOUR_TEXT)

if response.intent == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

```ruby
# With optional parameters
response = client.text_request(YOUR_TEXT, { token: YOUR_TOKEN, language: YOUR_LANGUAGE })
```

__If a language is provided:__ the language you've given is used for processing if your bot has expressions for it, else your bot's primary language is used.

__If no language is provided:__ the language of the text is detected and is used for processing if your bot has expressions for it, else your bot's primary language is used for processing.

### File request

file_request(file, options = {})

If you pass a token or a language in the option parameter, it will override your default client language or token.

__file format: .wav__
```ruby
response = client.file_request(File.new(File.join(File.dirname(__FILE__),YOUR_FILE)))

if response.intent == YOUR_EXPECTED_INTENT
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

#### Get the first detected intent

| Method        | Params | Return                    |
| ------------- |:------:| :-------------------------|
| intent()      |        | the first detected intent |

```ruby
response = client.text_request(YOUR_TEXT)

if response.intent == YOUR_EXPECTED_INTENT
  # Do your code...
end
```

#### Get the first sentence

| Method          | Params | Return             |
| --------------- |:------:| :------------------|
| sentence()      |        | the first sentence |

```ruby
response = client.text_request(YOUR_TEXT)

first_sentence = response.sentence
```

#### Get the first entity matching name

| Method     | Params        | Return                   |
| ---------- |:-------------:| :------------------------|
| get(name)  | name: String  | the first Entity matched |

```ruby
response = client.text_request(YOUR_TEXT)

location = response.get('location')
```

#### Get all entities matching name

| Method     | Params        | Return                   |
| ---------- |:-------------:| :------------------------|
| all(name)  | name: String  | all the Entities matched |

```ruby
response = client.text_request(YOUR_TEXT)

locations = response.all('location')
```

#### Getters

Each of the following methods corresponds to a Response attribute

| Method        | Params | Return                                              |
| ------------- |:------:| :---------------------------------------------------|
| raw()         |        | String: the raw unparsed json response              |
| source()      |        | String: the user input                              |
| intents()     |        | Array[object]: all the matched intents              |
| sentences()   |        | Array[Sentence]: all the detected sentences         |
| version()     |        | String: the version of the json                     |
| timestamp()   |        | String: the timestamp at the end of the processing  |
| status()      |        | String: the status of the response                  |
| type()        |        | String: the type of the response                    |


## RecastAI::Sentence

The Sentence is generated by the Recast.AI Response initializer

#### Get the first entity matching name

| Method     | Params        | Return                   |
| ---------- |:-------------:| :------------------------|
| get(name)  | name: String  | the first Entity matched |

```ruby
response = client.text_request(YOUR_TEXT)

sentence = response.sentence()

location = sentence.get('location')
```

#### Get all entities matching name

| Method     | Params        | Return                   |
| ---------- |:-------------:| :------------------------|
| all(name)  | name: String  | all the Entities matched |

```ruby
response = client.text_request(YOUR_TEXT)

sentence = response.sentence()

locations = sentence.all('location')
```

#### Getters

Each of the following methods corresponds to a Response attribute

| Method      | Params | Return                                               |
| ----------- |:------:| :----------------------------------------------------|
| source      |        | String: the source of the sentence                   |
| type        |        | String: the type of the sentence                     |
| action      |        | String: The action of the sentence                   |
| agent       |        | String: the agent of the sentence                    |
| polarity    |        | String: the polarity of the sentence                 |
| entities    |        | Array[Entity]: the entities detected in the sentence |

## RecastAI::Entity

Each of the following methods corresponds to a Response attribute

| Attributes  | Description                                                   |
| ----------- |:--------------------------------------------------------------|
| name        | String: the name of the entity                                |
| raw         | String: the unparsed json value of the entity                 |

In addition to those methods, more attributes are generated depending of the nature of the entity.
The full list can be found there: [man.recast.ai](https://man.recast.ai/#list-of-entities)

```ruby
response = client.text_request(YOUR_TEXT)

location = response.get('location')

puts location.raw()
puts location.name()
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
