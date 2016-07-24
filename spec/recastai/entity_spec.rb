# encoding: utf-8
describe RecastAI::Entity do
  it 'should be instanciable' do
    expect{ RecastAI::Entity.new('location', 'formated' => 'London, London, Greater London, England, United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97) }.not_to raise_error
  end

  it 'should have a name, and attributes' do
    entity = RecastAI::Entity.new('location', 'formated' => 'London, London, Greater London, England, United Kingdom', 'lat' => 51.5073509, 'lng' => -0.1277583, 'raw' => 'London', 'confidence' => 0.97)

    expect(entity.name).to eq('location')
    expect(entity.formated).to eq('London, London, Greater London, England, United Kingdom')
    expect(entity.lat).to eq(51.5073509)
    expect(entity.lng).to eq(-0.1277583)
    expect(entity.raw).to eq('London')
    expect(entity.confidence).to eq(0.97)
  end
end
