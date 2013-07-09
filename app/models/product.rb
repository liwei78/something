# Product Intro
# Posted at 2013-6-28 liwei


class Product < ActiveRecord::Base
  attr_accessible :name, :sku, :sale_price, :permalink, :description, :sale_price, :retail_price, :commission_amount, :available_on, :deleted_at, :blocked


  validates :name, :sku, presence: true

  # it's copy name and sku
  def copy_me
    self.sku += " (copy)"
    self.name += " (copy)"
  end
end
