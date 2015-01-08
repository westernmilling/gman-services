Rails.application.routes.draw do
  # devise_for :users
  use_doorkeeper

  scope '/api/v1/' do
    get 'drivers(.:format)',
        :to => 'api/v1/trucking/drivers#index',
        :defaults => { :format => 'json' }
    get 'driver_commissions_history(.:format)',
        :to => 'api/v1/trucking/driver_commissions_history#index',
        :defaults => { :format => 'json' }
    get 'driver_commissions_history_by_paid_date(.:format)',
        :to => 'api/v1/trucking/driver_commissions_history#by_paid_date',
        :defaults => { :format => 'json' }
  end
end
