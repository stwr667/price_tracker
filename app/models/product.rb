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
class Product < ActiveRecord::Base
  attr_accessible :name, :model, :description, :price, :delivery, :url, :deal_expiry
  
  before_save { |product| product.url = url.downcase }
  
  validates :name, presence: true, length: { maximum: 80 }
  validates :model, length: { maximum: 80 }
  validates :description, length: { maximum: 200 }
  validates :price, presence: true, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, 
              :numericality => {:greater_than => 0, :less_than => 1000000}
  validates :delivery, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, 
              :numericality => {:greater_than_or_equal_to => 0, :less_than => 10000}
  validates :url, :presence => true, 
    :format => { :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }

  validate :deal_expiry_is_valid_datetime

  def deal_expiry_is_valid_datetime
    if (deal_expiry.present? && (DateTime.parse(deal_expiry) rescue ArgumentError) == ArgumentError)
      errors.add(:deal_expiry, 'must be a valid datetime')
    end
  end
  
end
