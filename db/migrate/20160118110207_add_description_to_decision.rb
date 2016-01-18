class AddDescriptionToDecision < ActiveRecord::Migration
  def change
    add_column :decisions, :description, :text
  end
end
