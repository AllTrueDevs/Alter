class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.string :name
      t.string :status
      t.references :helper, index: true, references: :users
      t.references :request, index: true

      t.timestamps null: false
    end

    add_foreign_key :decisions, :users, column: :helper_id
    add_foreign_key :decisions, :requests
  end
end
