class CreateMovementTypes < ActiveRecord::Migration
  return if Rails.env == 'production'

  using(:grossman)
  def change
    create_table :movement_types do |t|
      t.string :movement_description
      t.integer :movement_cd

      t.timestamps
    end
  end
end
