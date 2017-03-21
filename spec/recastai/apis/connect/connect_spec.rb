# encoding: utf-8

describe RecastAI::Connect do
  it 'should be instanciable' do
    expect{ RecastAI::Connect.new }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Connect.new

    expect{ client.token }.not_to raise_error
    expect{ client.language }.not_to raise_error
    expect{ client.proxy }.not_to raise_error
  end

  it 'should send a message with a Connect object' do
    client = RecastAI::Connect.new('toto')
    conversation_id = 1

    stub_request(:post, "#{RecastAI::Utils::CONVERSATION_ENDPOINT}#{conversation_id}/messages").to_return(status: 200, body: '', headers: {})

    response = client.send_message({}, conversation_id)
    expect(response.code).to eq(200)
  end

  it 'should send a message with a Client object' do
    client = RecastAI::Client.new('toto')
    conversation_id = 1

    stub_request(:post, "#{RecastAI::Utils::CONVERSATION_ENDPOINT}#{conversation_id}/messages").to_return(status: 200, body: '', headers: {})

    response = client.connect.send_message({}, conversation_id)
    expect(response.code).to eq(200)
  end

  it 'should broadcast a message with a Connect object' do
    client = RecastAI::Connect.new('toto')

    stub_request(:post, RecastAI::Utils::MESSAGE_ENDPOINT).to_return(status: 200, body: '', headers: {})

    response = client.broadcast_message({})
    expect(response.code).to eq(200)
  end

  it 'should broadcast a message with a Client object' do
    client = RecastAI::Client.new('toto')

    stub_request(:post, RecastAI::Utils::MESSAGE_ENDPOINT).to_return(status: 200, body: '', headers: {})

    response = client.connect.broadcast_message({})
    expect(response.code).to eq(200)
  end

  it 'should parse a message' do
    client = RecastAI::Connect.new('toto')
    conversation_id = 1

    body = '{"message": {"conversation_id": "1", "attachment": {"content": "", "type": ""}}}'
    stub_request(:post, "#{RecastAI::Utils::CONVERSATION_ENDPOINT}#{conversation_id}/messages").to_return(status: 200, body: body, headers: {})

    response = client.send_message({}, conversation_id)
    msg = client.parse_message(response)
    expect(msg).to be_a(RecastAI::Msg)
  end
end
