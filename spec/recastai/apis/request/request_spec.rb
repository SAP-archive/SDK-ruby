# encoding: utf-8

describe RecastAI::Request do
  it 'should be instanciable' do
    expect{ RecastAI::Request.new }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Request.new

    expect{ client.token }.not_to raise_error
    expect{ client.language }.not_to raise_error
    expect{ client.proxy }.not_to raise_error
  end

  it 'should perform a text request via a Request object' do
    client = RecastAI::Request.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid': 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'slug' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'sentiment' => 'neutral', 'entities' => { 'location' => [{ 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris, France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-06T18:53:03.026120', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request/').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.analyse_text('This is my text')

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should perform a text request via a Client object' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid': 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'slug' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'sentiment' => 'neutral', 'entities' => { 'location' => [{ 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris, France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-06T18:53:03.026120', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request/').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.request.analyse_text('This is my text')

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should perform a voice file request via a Request object' do
    client = RecastAI::Request.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid': 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'slug' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'sentiment' => 'neutral', 'entities' => { 'location' => [{ 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris, France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-06T18:53:03.026120', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request/').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.analyse_file(File.new(File.join(File.dirname(__FILE__), '/../../../utils/test.wav')))

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should perform a voice file request via a Client object' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid': 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'slug' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'sentiment' => 'neutral', 'entities' => { 'location' => [{ 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris, France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-06T18:53:03.026120', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request/').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.request.analyse_file(File.new(File.join(File.dirname(__FILE__), '/../../../utils/test.wav')))

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should perform a text converse via a Request object' do
    client = RecastAI::Request.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15 =>26 =>11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/converse/').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.converse_text('What is the weather in Paris ?')

    # Testing the response
    expect(response).to be_a(RecastAI::Conversation)
  end

  it 'should perform a text converse via a Client object' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15 =>26 =>11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/converse/').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.request.converse_text('What is the weather in Paris ?')

    # Testing the response
    expect(response).to be_a(RecastAI::Conversation)
  end

  it 'should accept options overrides' do
    client = RecastAI::Request.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => {'uuid': 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'slug' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'sentiment' => 'neutral', 'entities' => { 'location' => [{ 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris, France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-06T18:53:03.026120', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request/').to_return(status: 200, body: body, headers: {})
    body = JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15 =>26 =>11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/converse/').to_return(status: 200, body: body, headers: {})

    # Testing the methods
    text_response = client.analyse_text('This is my text', token: 'tokentest', language: 'fr')
    file_response = client.analyse_file(File.new(File.join(File.dirname(__FILE__), '/../../../utils/test.wav')), token: 'tokentest', language: 'fr')
    text_conversation = client.converse_text('This is my text', token: 'tokentest', language: 'fr', conversation_token: 'conversationtokentest', memory: { lieu: { lat: 0.54, lnt: 0.435 } })

    # Testing the responses
    expect(text_response).to be_a(RecastAI::Response)
    expect(file_response).to be_a(RecastAI::Response)
    expect(text_conversation).to be_a(RecastAI::Conversation)
  end
end
