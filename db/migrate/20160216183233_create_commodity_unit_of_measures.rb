class CreateCommodityUnitOfMeasures < ActiveRecord::Migration
  return if Commodity::UnitOfMeasure
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Commodity::UnitOfMeasure.connection

    create_table :CommodityUOM do |t|
      t.integer :CommUOMId, null: false
      t.string :CommUOMDescription, null: false

      t.timestamps
    end
  end
end
