Rails.application.routes.draw do
  scope '/api/v1' do
    get 'drivers(.:format)',
        :to => 'api/v1/drivers#index',
        :defaults => { :format => 'json' }
  end
end
