module Api
  module Endpoint
    class Device < Api::Base
      resource :devices do
        desc 'Device registration'
        params do
          requires :device_id, type: String
          requires :pass_type_id, type: String
          requires :serial_number, type: String
        end

        post ':device_id/registrations/:pass_type_id/:serial_number' do
          { status: 'ok', device_id: params[:device_id], pass_type_id: params[:pass_type_id], serial_number: params[:serial_number] }
        end

        desc 'Check passes for updates'
        params do
          requires :device_id, type: String
          requires :pass_type_id, type: String
          optional :passesUpdatedSince, type: String
        end

        get ':device_id/registrations/:pass_type_id' do
          { status: 'ok', device_id: params[:device_id], pass_type_id: params[:pass_type_id], serial_number: params[:serial_number] }
        end

        desc 'Unregister device'
        params do
          requires :device_id, type: String
          requires :pass_type_id, type: String
          requires :serial_number, type: String
        end

        delete ':device_id/registrations/:pass_type_id/:serial_number' do
          { status: 'ok', device_id: params[:device_id], pass_type_id: params[:pass_type_id], serial_number: params[:serial_number] }
        end
      end
    end
  end
end