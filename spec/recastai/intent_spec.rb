# encoding: utf-8

describe RecastAI::Intent do
  it 'should be instanciable' do
    expect{ RecastAI::Intent.new('name' => 'weather', 'confidence' => 0.67) }.not_to raise_error
  end

  it 'should have attributes' do
    intent = RecastAI::Intent.new('name' => 'weather', 'confidence' => 0.67)

    expect(intent.name).to eq('weather')
    expect(intent.confidence).to eq(0.67)
  end
end
