scope '/api/v1/' do
  get 'inventory/items(.:format)',
      to: 'api/v1/inventory/items#index',
      defaults: { format: 'json' }
  get 'inventory/items_like_id_description(.:format)',
      to: 'api/v1/inventory/items#like_id_description',
      defaults: { format: 'json' }
  get 'inventory/items_by_id(.:format)',
      to: 'api/v1/inventory/items#by_id',
      defaults: { format: 'json' }
end
