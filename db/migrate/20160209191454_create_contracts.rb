class CreateContracts < ActiveRecord::Migration
  return if Contract.connection.class.to_s.include?('Relativity')

  def change
    @connection = Contract.connection

    create_table :Contract do |t|
      t.string :ContractId
      t.string :CustomerId
      t.string :CommodityId
      t.integer :CommUOMId
      t.integer :CONT_ContractNumber
      t.string :CONT_ContractType
      t.date :CONT_ContractDate
      t.integer :CONT_Quantity
      t.integer :CONT_DeliveredBushels
      t.decimal :CONT_Price, precision: 9, scale: 5
      t.decimal :CONT_FreightAdjustment, precision: 9, scale: 5
      t.date :CONT_FromDate
      t.date :CONT_ToDate
    end
  end
end
