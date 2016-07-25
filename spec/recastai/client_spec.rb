# encoding: utf-8

describe RecastAI::Client do
  it 'should be instanciable' do
    expect{ RecastAI::Client.new }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Client.new

    expect{ client.token }.not_to raise_error
  end

  it 'should perform a text request' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.text_request('This is my text')

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should perform a voice file request' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request').to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.file_request(File.new(File.join(File.dirname(__FILE__), '/../utils/test.wav')))

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should accept options overrides' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success')
    stub_request(:post, 'https://api.recast.ai/v2/request').to_return(status: 200, body: body, headers: {})

    # Testing the methods
    text_response = client.text_request('This is my text', token: 'tokentest', language: 'fr')
    file_response = client.file_request(File.new(File.join(File.dirname(__FILE__), '/../utils/test.wav')), token: 'tokentest', language: 'fr')

    # Testing the responses
    expect(text_response).to be_a(RecastAI::Response)
    expect(file_response).to be_a(RecastAI::Response)
  end
end
