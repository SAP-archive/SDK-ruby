# encoding: utf-8

describe RecastAI::Action do
  it 'should be instanciable' do
    expect{ RecastAI::Action.new('slug' => 'greetings', 'done' => true, 'reply' => 'Hey there!') }.not_to raise_error
  end

  it 'should have attributes' do
    action = RecastAI::Action.new('slug' => 'greetings', 'done' => true, 'reply' => 'Hey there!')

    expect(action.slug).to eq('greetings')
    expect(action.done).to eq(true)
    expect(action.done?).to eq(true)
    expect(action.reply).to eq('Hey there!')
  end
end
