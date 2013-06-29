# Paperclip 3.0 introduces a non-backward compatible change in your attachment
# path. This will help to prevent attachment name clashes when you have
# multiple attachments with the same name. If you didn't alter your
# attachment's path and are using Paperclip's default, you'll have to add
# `:path` and `:url` to your `has_attached_file` definition. For example:

#     has_attached_file :avatar,
#       :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
#       :url => "/system/:attachment/:id/:style/:filename"


class CsvFile < ActiveRecord::Base
  attr_accessible :file_name

  def dump_products
    products = []
    n = 0
    CSV.foreach(File.join(Rails.root, 'public', 'csv', "#{self.file_name}.csv")) do |row|
      if n == 0
        n += 1
        next
      else
        products << {
          id: n,
          sku: row[0],
          name: row[1],
          sale_price: row[2],
          commission_amount: row[3],
          retail_price: row[4],
        }
        n += 1
      end      
    end
    products
  end

end
