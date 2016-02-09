class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
            t.string :name
            t.integer :helper_id
            t.integer :request_id
            t.string :status

            t.timestamps null: false
       end
  end
end
