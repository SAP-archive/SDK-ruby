# encoding: utf-8

REQUEST = '{"message": {"conversation": "1", "attachment": {"content": "", "type": ""}}}'

describe RecastAI::Msg do
  it 'should be instanciable' do
    expect{ RecastAI::Msg.new(REQUEST) }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Connect.new('toto')
    conversation_id = 1

    body = '{"message": {"conversation": "1", "attachment": {"content": "", "type": ""}}}'
    stub_request(:post, "#{RecastAI::Utils::CONVERSATION_ENDPOINT}#{conversation_id}/messages").to_return(status: 201, body: body, headers: {})

    request = client.send_message({}, conversation_id)
    msg = RecastAI::Msg.new(request.body)

    expect(msg.content).to eq('')
    expect(msg.type).to eq('')
    expect(msg.conversation_id).to eq('1')
  end
end
