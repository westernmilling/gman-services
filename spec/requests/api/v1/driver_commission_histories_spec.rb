# require 'rails_helper'
#
# RSpec.describe '/api/v1/all', :type => :request do
#   let(:all) do
#     DriverCommissionHistoryAdapter.all
#   end
#
#   let(:by_paid_date) do
#     DriverCommissionHistoryAdapter.by_paid_date(Date.new(2014, 01, 01))
#   end
#
#   it 'responds with all driver commission history json' do
#     get '/api/v1/driver_commission_history'
#
#     expect(response.body).to eq(all.to_json)
#   end
#
#   # it 'responds with all driver commission history json' do
#   #   get '/api/v1/driver_commission_history_by_paid_date'
#   #
#   #   expect(response.body).to eq(by_paid_date.to_json)
#   # end
# end
