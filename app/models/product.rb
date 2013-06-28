# Product Intro
# Posted at 2013-6-28 liwei


class Product < ActiveRecord::Base
  attr_accessible :name, :sku, :sale_price, :permalink, :description, :sale_price, :retail_price, :commission_amount, :available_on, :deleted_at
end
