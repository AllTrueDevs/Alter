class RequiredItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :request
end
