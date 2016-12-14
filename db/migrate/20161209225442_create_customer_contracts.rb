class CreateCustomerContracts < ActiveRecord::Migration
  def change
    return if CustomerContract
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = CustomerContract.connection

    create_table :Contract_Customers, id: false do |t|
      t.string :CustomerId, null: false
      t.string :InvContractId, null: false
      t.string :LocationId, null: false
      t.string :ContractType, null: false
    end
  end
end
