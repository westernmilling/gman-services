class CreateContracts < ActiveRecord::Migration
  return if Contract.connection.class.to_s.include?('Relativity')

  def change
    @connection = Contract.connection

    create_table :contracts do |t|
      t.string :contract_id
      t.string :customer_id
      t.string :commodity_id
      t.integer :cont_contract_number
      t.string :cont_contract_type
      t.date :cont_contract_date
      t.integer :cont_quantity
      t.integer :cont_delivered_bushels
      t.decimal :cont_price, precision: 9, scale: 5
      t.decimal :cont_freightadjustment, precision: 9, scale: 5
      t.date :cont_from_date
      t.date :cont_to_date
    end
  end
end
