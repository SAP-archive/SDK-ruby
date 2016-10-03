# encoding: utf-8

describe RecastAI::RecastError do
  it 'should be instanciable' do
    expect{ RecastAI::RecastError.new('error') }.not_to raise_error
  end

  it 'should have a message' do
    error = RecastAI::RecastError.new('error')

    expect(error.message).to eq('error')
  end
end
