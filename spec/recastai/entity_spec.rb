describe RecastAI::Entity do
  it 'should be instanciable' do
    expect{ RecastAI::Entity.new('entity', { 'value' => 'value', 'raw' => 'value' }) }.not_to raise_error
  end

  it 'should have a name, and attributes' do
    entity = RecastAI::Entity.new('entity', { 'value' => 'value', 'raw' => 'raw' })

    expect(entity.name).to eq('entity')
    expect(entity.value).to eq('value')
    expect(entity.raw).to eq('raw')
  end
end
