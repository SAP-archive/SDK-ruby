# encoding: utf-8

describe RecastAI::Train do
  it 'should be instanciable' do
    expect{ RecastAI::Train.new }.not_to raise_error
  end

  it 'should have attributes' do
    client = RecastAI::Train.new

    expect{ client.token }.not_to raise_error
    expect{ client.language }.not_to raise_error
    expect{ client.proxy }.not_to raise_error
  end
end
