class CreateCommodityUnitOfMeasures < ActiveRecord::Migration
  def change
    return if Commodity::UnitOfMeasure
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Commodity::UnitOfMeasure.connection

    create_table :CommodityUOM do |t|
      t.integer :CommUOMId, null: false
      t.string :CommUOMDescription, null: false

      t.timestamps
    end
  end
end
