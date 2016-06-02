class AddSettlementAndSettlementTypeAndRegionAndDistrictToUser < ActiveRecord::Migration
  def change
    add_column :users, :settlement, :string
    add_column :users, :settlement_type, :string
    add_column :users, :region, :string
    add_column :users, :district, :string
  end
end
