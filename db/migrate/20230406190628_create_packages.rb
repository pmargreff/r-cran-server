class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :md5
      t.string :author

      t.timestamps
    end
  end
end
