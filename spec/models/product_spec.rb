# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  model       :string(255)
#  description :string(255)
#  price       :decimal(, )
#  delivery    :decimal(, )
#  url         :string(255)
#  deal_expiry :datetime
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#
require 'spec_helper'

describe Product do
  before do
    @product = Product.new(name: "Samsung Galaxy Nexus", model: "I9250",
                           description: "Android 4.1 Smartphone, pure google",
                           price: 359, delivery: 19.95,
                           url: "http://www.kogan.com/au/buy/samsung-galaxy-nexus/",
                           deal_expiry: nil)
  end
  
  subject { @product }
  
  it { should respond_to(:name) }
  it { should respond_to(:model) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
  it { should respond_to(:delivery) }
  it { should respond_to(:url) }
  it { should respond_to(:deal_expiry) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @product.name = " " }
    it { should_not be_valid }
  end
  
  describe "when price is not present" do
    before { @product.price = 0 }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { @product.url = " " }
    it { should_not be_valid }
  end
  
  describe "when url format is invalid" do
    it "should be invalid" do
      urls = %w[htp://www.google.com http//www.google.com http:/www.google.com
                     http:// http://!@#$%^&*()]
      urls.each do |invalid_url|
        @product.url = invalid_url
        @product.should_not be_valid
      end
    end
  end
  
end
