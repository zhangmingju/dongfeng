require "rails_helper"

RSpec.describe Category, :type => :model do
  it "name is must" do 
    category = Category.new(name: "test")
    expect(category).to be_valid
  end
end