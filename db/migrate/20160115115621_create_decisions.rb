class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
            t.string :name

            t.timestamps null: false
       end
  end
end
