class AddContractSubToContracts < ActiveRecord::Migration
  def change
    return if Contract
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Contract.connection

    add_column :Contract,
               :CONT_ContractSub,
               :string
  end
end
