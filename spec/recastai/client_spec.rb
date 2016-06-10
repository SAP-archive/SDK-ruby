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
    body = JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'})
    stub_request(:post, "https://api.recast.ai/v1/request").to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.text_request('This is my text')

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should perform a voice file request' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'})
    stub_request(:post, "https://api.recast.ai/v1/request").to_return(status: 200, body: body, headers: {})

    # Testing the method
    response = client.file_request(File.new(File.join(File.dirname(__FILE__), '/../utils/test.wav')))

    # Testing the response
    expect(response).to be_a(RecastAI::Response)
  end

  it 'should accept options overrides' do
    client = RecastAI::Client.new('testtoken')

    # Stubbing the request
    body = JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'})
    stub_request(:post, "https://api.recast.ai/v1/request").to_return(status: 200, body: body, headers: {})

    # Testing the methods
    text_response = client.text_request('This is my text', token: 'tokentest', language: 'fr')
    file_response = client.file_request(File.new(File.join(File.dirname(__FILE__), '/../utils/test.wav')), token: 'tokentest', language: 'fr')

    # Testing the responses
    expect(text_response).to be_a(RecastAI::Response)
    expect(file_response).to be_a(RecastAI::Response)
  end
end
