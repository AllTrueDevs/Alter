class Category < ActiveRecord::Base
  has_many :required_items
end
