describe RecastAI::RecastError do
  it 'should be instanciable' do
    expect{ RecastAI::RecastError.new('error', 200) }.not_to raise_error
  end

  it 'should have a message and a code' do
    error = RecastAI::RecastError.new('error', 200)

    expect(error.message).to eq('error')
    expect(error.code).to eq(200)
  end
end
