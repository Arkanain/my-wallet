require 'rails_helper'

describe Api::Endpoint::Device do
  def app
    Api::Base
  end

  it 'should register device' do
    post 'api/devices/123/registrations/234/345'

    expect(response.successful?).to be_truthy
    expect(body[:device_id]).to eq('123')
    expect(body[:pass_type_id]).to eq('234')
    expect(body[:serial_number]).to eq('345')
  end

  it 'should check passes for update' do
    get 'api/devices/123/registrations/234'

    expect(response.successful?).to be_truthy
    expect(body[:device_id]).to eq('123')
    expect(body[:pass_type_id]).to eq('234')
  end

  it 'should unregister device' do
    delete 'api/devices/123/registrations/234/345'

    expect(response.successful?).to be_truthy
    expect(body[:device_id]).to eq('123')
    expect(body[:pass_type_id]).to eq('234')
    expect(body[:serial_number]).to eq('345')
  end
end