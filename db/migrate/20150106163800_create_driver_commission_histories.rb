class CreateDriverCommissionHistories < ActiveRecord::Migration
  return if DriverCommissionHistory.connection.class.to_s.include?('Relativity')

  def change
    @connection = DriverCommissionHistory.connection

    create_table :Trucking_Drivers_Commissions_History do |t|
      t.integer :DriverId, foreign_key: false
      t.string :Backhauls
      t.integer :FreightRevenue
      t.integer :CustomerId, foreign_key: false
      t.string :CustomerName
      t.date :DeliveryDate
      t.integer :DriverRate
      t.integer :FreightBillNumber
      t.integer :FuelSurcharge
      t.string :Layover
      t.string :MovementType
      t.string :MovementCd
      t.integer :OtherHourDollars
      t.string :OrderNumberText
      t.string :OriginName
      t.date :PaidDate
      t.integer :Revenue
      t.integer :SplitRate
      t.integer :TotalFreightRevenue
      t.string :DrvrcomhKey

      t.timestamps
    end
  end
end
