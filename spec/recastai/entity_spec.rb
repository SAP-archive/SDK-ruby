# encoding: utf-8
describe RecastAI::Entity do
  it 'should be instanciable' do
    expect{ RecastAI::Entity.new('location', 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'type'=> 'locality', 'place' => 'QWEJKqkrqwrqw786423b', 'raw' => 'London', 'confidence' => 0.97) }.not_to raise_error
  end

  it 'should have a name, and attributes' do
    entity = RecastAI::Entity.new('location', 'formated' => 'London, UK', 'lat' => 51.5073509, 'lng' => -0.1277583, 'type'=> 'locality', 'place' => 'QWEJKqkrqwrqw786423b','raw' => 'London', 'confidence' => 0.97)

    expect(entity.name).to eq('location')
    expect(entity.formated).to eq('London, UK')
    expect(entity.lat).to eq(51.5073509)
    expect(entity.lng).to eq(-0.1277583)
    expect(entity.type).to eq('locality')
    expect(entity.place).to eq('QWEJKqkrqwrqw786423b')
    expect(entity.raw).to eq('London')
    expect(entity.confidence).to eq(0.97)
  end
end
