require 'rails_helper'

RSpec.describe "decisions/show", :type => :view do
  before(:each) do
    @notification = assign(:notification, Decision.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
