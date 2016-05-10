require 'spec_helper'

describe "Static Pages" do
  subject { page }

  describe "home page" do
    before { visit '/static_pages/home' }
    it { should have_title full_title('Home') } 
  end
end
