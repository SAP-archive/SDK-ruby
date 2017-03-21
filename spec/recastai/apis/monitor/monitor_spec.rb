# encoding: utf-8

describe RecastAI::Monitor do
  it 'should be instanciable' do
    expect{ RecastAI::Monitor.new }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Monitor.new

    expect{ client.token }.not_to raise_error
    expect{ client.language }.not_to raise_error
    expect{ client.proxy }.not_to raise_error
  end
end
