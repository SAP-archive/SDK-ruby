

[logo]: https://cdn.cai.tool.sap/brand/sapcai/sap-cai-black.svg "SAP Conversational AI"

![alt text][logo]

# SAP Conversational AI - SDK Ruby

SAP Conversational AI official SDK in Ruby

## Synospis

This module is a wrapper around the [SAP Conversational AI](https://cai.tool.sap) API, and allows you to:
* [Analyse your text](https://github.com/SAPConversationalAI/SDK-Ruby/wiki/01---Analyse-text)
* [Manage a conversation](https://github.com/SAPConversationalAI/SDK-Ruby/wiki/02---Manage-conversation)
* [Receive and send messages](https://github.com/SAPConversationalAI/SDK-Ruby/wiki/03---Receive-and-send-messages)

## Installation

This gem supports ruby 2.3+.

```bash
gem install Sapcai
```

You can now use the sdk in your code. All you need is your bot's token. In case you have enabled our versioning feature in the settings of your bot, you can refer to our [versioning documentation](https://cai.tools.sap/docs/concepts/versioning) to learn how to select the appropriate token for you versions and environments.

Using the entire SDK:
```ruby
require 'sapcai'

client = Sapcai::Client.new('YOUR_TOKEN')

client.request.analyse_text('Hi')
client.connect.broadcast_message('Hello')
```

Extracting one single API:
```ruby
require 'sapcai'

request = Sapcai::Request.new('YOUR_TOKEN')
request.analyse_text('Hi')

connect = Sapcai::Connect.new('YOUR_TOKEN')
connect.broadcast_message('Hi')
```

## More

You can view the whole API reference at [cai.tool.sap/docs/](https://cai.tool.sap/docs/api-reference).


## Author

Paul Renvoisé, paul.renvoise@sap.com, [@paulrenvoise](https://twitter.com/paulrenvoise)

You can follow us on Twitter at [@sapcai](https://twitter.com/sapcai) for updates and releases.


## License

Copyright (c) [2019] [SAP Conversational AI](https://cai.tool.sap)

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
