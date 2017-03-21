# encoding: utf-8

REQUEST = '{"message": {"conversation_id": "1", "attachment": {"content": "", "type": ""}}}'

describe RecastAI::Msg do
  it 'should be instanciable' do
    expect{ RecastAI::Msg.new(REQUEST, 'toto') }.not_to raise_error
  end

  it 'should have attributes' do
    msg = RecastAI::Msg.new(REQUEST, 'toto')

    expect(msg.token).to eq('toto')
    expect(msg.content).to eq('')
    expect(msg.type).to eq('')
    expect(msg.conversation_id).to eq('1')
    expect(msg.replies).to eq([])
  end

  it 'should add replies' do
    msg = RecastAI::Msg.new(REQUEST, 'toto')

    msg.add_replies('COUCOU')
    expect(msg.replies).to eq(['COUCOU'])

    msg.add_replies(['TU VEUX VOIR'])
    expect(msg.replies).to eq(['COUCOU', 'TU VEUX VOIR'])
  end

  it 'should reply' do
    msg = RecastAI::Msg.new(REQUEST, 'toto')
    conversation_id = 1

    stub_request(:post, "#{RecastAI::Utils::CONVERSATION_ENDPOINT}#{conversation_id}/messages").to_return(status: 200, body: '', headers: {})

    response = msg.reply()
    expect(response.code).to eq(200)
  end
end
