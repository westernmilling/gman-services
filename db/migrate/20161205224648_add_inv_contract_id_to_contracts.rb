class AddInvContractIdToContracts < ActiveRecord::Migration
  def change
    return if Contract
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Contract.connection

    add_column :Contract,
               :Inv_ContractId,
               :string
  end
end
