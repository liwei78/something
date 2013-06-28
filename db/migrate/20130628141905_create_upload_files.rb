class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
    end
  end

  def self.up
    add_attachment :upload_files, :file
  end

  def self.down
    remove_attachment :upload_files, :file
  end
end
