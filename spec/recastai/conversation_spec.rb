# encoding: utf-8

describe RecastAI::Conversation do
  it 'should be instanciable' do
    expect{ RecastAI::Conversation.new(JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15:26:11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success')) }.not_to raise_error
  end

  it 'should have attributes' do
    conversation = RecastAI::Conversation.new(JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15:26:11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success'))

    expect(conversation.raw).to eq(JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15:26:11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success'))
    expect(conversation.uuid).to eq('db4837b0-8359-4505-9678-c4081a6f2ad8')
    expect(conversation.source).to eq('What is the weather in Paris ?')
    expect(conversation.replies).to be_a(Array)
    expect(conversation.replies[0]).to be_a(String)
    expect(conversation.action).to be_a(RecastAI::Action)
    expect(conversation.next_actions).to be_a(Array)
    expect(conversation.next_actions[0]).to be_a(RecastAI::Action)
    expect(conversation.memory).to be_a(Array)
    expect(conversation.memory[0]).to be_a(RecastAI::Entity)
    expect(conversation.entities).to be_a(Array)
    expect(conversation.intents).to be_a(Array)
    expect(conversation.conversation_token).to eq('8641d38b059cde2826e3cdf2f9b00725')
    expect(conversation.language).to eq('en')
    expect(conversation.version).to eq('2.0.0')
    expect(conversation.timestamp).to eq('2016-10-04T15:26:11.876Z')
    expect(conversation.status).to eq(200)
  end

  it 'should have helper methods' do
    conversation = RecastAI::Conversation.new(JSON.generate('results' => {'uuid' => 'db4837b0-8359-4505-9678-c4081a6f2ad8', 'source' => 'What is the weather in Paris ?', 'replies' => ['Do you already have an account?', 'This is a test?'], 'action' => { 'slug' => 'murder', 'done' => false, 'reply' => 'do you already have an account?' }, 'next_actions' => [{ 'slug' => 'test', 'done' => false, 'reply' => 'This is a test?' }], 'memory' => { 'victim' => nil, 'client' => nil, 'mail-client' => nil, 'lieu' => { 'lat' => 0.54, 'lng' => 0.435 }}, 'entities' => {}, 'intents' => [], 'conversation_token' => '8641d38b059cde2826e3cdf2f9b00725', 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-10-04T15:26:11.876Z', 'status' => 200}, 'message' => 'Converses rendered with success'))

    expect(conversation.reply()).to eq(conversation.replies[0])
    expect(conversation.next_action()).to eq(conversation.next_actions[0])
    expect(conversation.joined_replies()).to eq(conversation.replies.join(' '))
    expect(conversation.joined_replies("\n")).to eq(conversation.replies.join("\n"))
    expect(conversation.get_memory()).to eq(conversation.memory)
    expect(conversation.get_memory('lieu')).to eq(conversation.memory.each{ |e| break e if e.name.casecmp('lieu') == 0 })
    expect(conversation.intent()).to eq(nil)
  end
end
