# encoding: utf-8

describe RecastAI::Host do
  it 'should be instanciable' do
    expect{ RecastAI::Host.new }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Host.new

    expect{ client.token }.not_to raise_error
    expect{ client.language }.not_to raise_error
    expect{ client.proxy }.not_to raise_error
  end
end
