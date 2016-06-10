describe RecastAI::Response do
  it 'should be instanciable' do
    expect{ RecastAI::Response.new(JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'})) }.not_to raise_error
  end

  it 'should have attributes' do
    response = RecastAI::Response.new(JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'}))

    expect(response.raw).to eq(JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'}))
    expect(response.source).to eq("What's the weather in London?")
    expect(response.intents).to be_a(Array)
    expect(response.intents).to eq(['test'])
    expect(response.sentences).to be_a(Array)
    expect(response.sentences.first).to be_a(RecastAI::Sentence)
    expect(response.version).to eq('0.1.4')
    expect(response.timestamp).to eq('2016-05-01T17:33:00+02:00')
    expect(response.status).to eq(200)
  end

  it 'should have helper methods' do
    response = RecastAI::Response.new(JSON.generate({'results'=>{'source'=>"What's the weather in London?",'intents'=>['test'],'sentences'=>[{'source'=>"What's the weather in London?",'type'=>'what','action'=>'be','agent'=>'the weather in london','polarity'=>'positive','entities'=>{'location'=>[{'formated'=>'London, London, Greater London, England, United Kingdom','lat'=>51.5073509,'lng'=>-0.1277583,'raw'=>'London'}]}}],'version'=>'0.1.4','timestamp'=>'2016-05-01T17:33:00+02:00','status'=>200},'message'=>'Requests rendered with success.'}))

    expect(response.intent).to eq(response.intents.first)
    expect(response.sentence).to eq(response.sentences.first)
    entity = response.sentence.entities.each{ |e| break e if e.name.downcase == 'location' }
    expect(response.get('location')).to eq(entity)
    entities = response.sentence.entities.map{ |e| e if e.name.downcase == 'location' }
    expect(response.all('location')).to eq(entities)
    entities = response.sentences.map{ |s| s.entities }.flatten
    expect(response.entities).to eq(entities)
  end
end

