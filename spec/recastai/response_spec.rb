# encoding: utf-8

describe RecastAI::Response do
  it 'should be instanciable' do
    expect{ RecastAI::Response.new(JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success')) }.not_to raise_error
  end

  it 'should have attributes' do
    response = RecastAI::Response.new(JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success'))

    expect(response.raw).to eq(JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success'))
    expect(response.source).to eq('What is the weather in London tomorrow? And in Paris?')
    expect(response.intents).to be_a(Array)
    expect(response.intents.first).to be_a(RecastAI::Intent)
    expect(response.act).to eq('wh-query')
    expect(response.type).to eq('desc:desc')
    expect(response.negated?).to eq(false)
    expect(response.sentiment).to eq('neutral')
    expect(response.entities).to be_a(Array)
    expect(response.entities.first).to be_a(RecastAI::Entity)
    expect(response.language).to eq('en')
    expect(response.version).to eq('2.0.0')
    expect(response.timestamp).to eq('2016-07-10T23:17:59+02:00')
    expect(response.status).to eq(200)
  end

  it 'should have helper methods' do
    response = RecastAI::Response.new(JSON.generate('results' => { 'source' => 'What is the weather in London tomorrow? And in Paris?', 'intents' => [{ 'name' => 'weather', 'confidence' => 0.67 }], 'act' => 'wh-query', 'type' => 'desc:desc', 'negated' => 0, 'sentiment' => 'neutral', 'entities' => { 'action' => [{ 'agent' => 'the weather in London', 'tense' => 'present', 'raw' => 'is', 'confidence' => 0.89 }], 'location' => [{ 'formated' => 'London,  London,  Greater London,  England,  United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97 }, { 'formated' => 'Paris,  Paris,  Île-de-France,  France', 'lat' => 48.856614, 'lng' => 2.3522219, 'raw' => 'Paris', 'confidence' => 0.83 }], 'datetime' => [{ 'value' => '2016-07-11T10:00:00+00:00', 'raw' => 'tomorrow', 'confidence' => 0.95 }] }, 'language' => 'en', 'version' => '2.0.0', 'timestamp' => '2016-07-10T23:17:59+02:00', 'status' => 200 }, 'message' => 'Requests rendered with success'))

    expect(response.intent).to eq(response.intents.first)
    entity = response.entities.each{ |e| break e if e.name.casecmp('location') == 0 }
    expect(response.get('location')).to eq(entity)
    entities = response.entities.select{ |e| e.name.casecmp('location') == 0 }
    expect(response.all('location')).to eq(entities)
    expect(response.assert?).to eq(false)
    expect(response.command?).to eq(false)
    expect(response.wh_query?).to eq(true)
    expect(response.yn_query?).to eq(false)
    expect(response.abbreviation?).to eq(false)
    expect(response.entity?).to eq(false)
    expect(response.description?).to eq(true)
    expect(response.human?).to eq(false)
    expect(response.location?).to eq(false)
    expect(response.number?).to eq(false)
    expect(response.positive?).to eq(false)
    expect(response.neutral?).to eq(true)
    expect(response.negative?).to eq(false)
  end
end
