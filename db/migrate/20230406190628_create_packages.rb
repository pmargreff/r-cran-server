class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :title
      t.string :license
      t.string :md5
      t.string :maintainer
      t.string :dependencies
      t.datetime :publication_date
      t.string :version
      t.string :author

      t.timestamps
    end
  end
end
