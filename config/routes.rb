module ActionDispatch
  module Routing
    class Mapper
      def draw(routes_name)
        instance_eval(
          File.read(Rails.root.join("config/routes/#{routes_name}.rb"))
        )
      end
    end
  end
end

Rails.application.routes.draw do
  use_doorkeeper

  draw :items

  scope '/api/v1', module: 'api/v1' do
    scope 'commodity_merchandising', module: 'commodity_merchandising' do
      resources :contracts, only: [:index], defaults: { format: 'json' }
      resources :bulk_contracts, only: [:index], defaults: { format: 'json' }
    end
    get 'customer_contracts(.:format)',
        to: 'customer_contracts#index',
        defaults: { format: 'json' }

    get 'drivers(.:format)',
        to: 'trucking/drivers#index',
        defaults: { format: 'json' }

    get 'driver_commissions_history(.:format)',
        to: 'trucking/driver_commissions_history#index',
        defaults: { format: 'json' }
    get 'driver_commissions_history_by_paid_date(.:format)',
        to: 'trucking/driver_commissions_history#by_paid_date',
        defaults: { format: 'json' }

    get 'health_check', to: 'health_check#index', defaults: { format: 'json' }

    resources :orders, only: [:show, :index], defaults: { format: 'json' }
    resources :pick_up_orders, only: [:index], defaults: { format: 'json' }
  end
end
