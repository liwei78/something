class CreateCsvFiles < ActiveRecord::Migration
  def change
    create_table :csv_files do |t|
      t.string :file_name
      t.timestamps
    end
  end
end
