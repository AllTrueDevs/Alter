require 'rails_helper'

RSpec.describe "decisions/new", :type => :view do
  before(:each) do
    assign(:notification, Decision.new())
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do
    end
  end
end
