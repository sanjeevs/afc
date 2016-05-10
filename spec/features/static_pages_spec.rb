require 'spec_helper'

describe "Static Pages" do
  subject { page }

  describe "home page" do
    it "should have the title AFC | Home" do
      visit  '/static_pages/home'
      should have_title "AFC | Home"
    end
  end
end
