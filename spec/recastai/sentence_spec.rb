describe RecastAI::Sentence do
  it 'should be instanciable' do
    expect{ RecastAI::Sentence.new({'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}) }.not_to raise_error
  end

  it 'should have a name, and attributes' do
    sentence = RecastAI::Sentence.new({'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}})

    expect(sentence.source).to eq("What's the weather in London?")
    expect(sentence.type).to eq('what')
    expect(sentence.action).to eq('be')
    expect(sentence.agent).to eq('the weather in london')
    expect(sentence.polarity).to eq('positive')
    expect(sentence.entities).to be_a(Array)
    expect(sentence.entities.first).to be_a(RecastAI::Entity)
  end
end

