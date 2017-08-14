class AddFobLocationDescriptionToContracts < ActiveRecord::Migration
  def change
    return if Contract
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Contract.connection

    add_column :Contract,
               :CONT_FobLocationDescription,
               :string
    add_column :Contract,
               :CONT_FobLocationDescription1,
               :string
  end
end
