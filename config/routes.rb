Rails.application.routes.draw do
  # devise_for :users
  use_doorkeeper

  scope '/api/v1/' do
    scope 'commodity_merchandising' do
      get 'contracts(.:format)',
          to: 'api/v1/commodity_merchandising/contracts#index',
          defaults: { format: :json }
    end

    get 'drivers(.:format)',
        to: 'api/v1/trucking/drivers#index',
        defaults: { format: 'json' }

    get 'driver_commissions_history(.:format)',
        to: 'api/v1/trucking/driver_commissions_history#index',
        defaults: { format: 'json' }
    get 'driver_commissions_history_by_paid_date(.:format)',
        to: 'api/v1/trucking/driver_commissions_history#by_paid_date',
        defaults: { format: 'json' }

    get 'inventory/items(.:format)',
        to: 'api/v1/inventory/items#index',
        defaults: { format: 'json' }
    get 'inventory/items_like_id_description(.:format)',
        to: 'api/v1/inventory/items#like_id_description',
        defaults: { format: 'json' }
    get 'inventory/items_by_id(.:format)',
        to: 'api/v1/inventory/items#by_id',
        defaults: { format: 'json' }
    get 'inventory/pallets(.:format)',
        to: 'api/v1/inventory/pallets#index',
        defaults: { format: 'json' }
  end
end
