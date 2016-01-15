require 'rails_helper'

RSpec.describe "decisions/index", :type => :view do
  before(:each) do
    assign(:decisions, [
      Decision.create!(),
      Decision.create!()
    ])
  end

  it "renders a list of decisions" do
    render
  end
end
