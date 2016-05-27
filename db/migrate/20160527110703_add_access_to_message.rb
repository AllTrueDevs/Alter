class AddAccessToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :access, :string, default: :both
  end
end
