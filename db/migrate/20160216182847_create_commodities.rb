class CreateCommodities < ActiveRecord::Migration
  return if Commodity.connection.class.to_s.include?('Relativity')

  def change
    @connection = Commodity.connection

    create_table :Commodity do |t|
      t.integer :CommodityId, null: false
      t.string :COMM_Description, null: false
      t.integer :COMM_CommUOMId, null: false
      t.integer :COMM_ConversionFactor, null: false

      t.timestamps
    end
  end
end
