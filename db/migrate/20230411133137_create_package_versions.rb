class CreatePackageVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :package_versions do |t|
      t.string :version
      t.belongs_to :package

      t.timestamps
    end
  end
end
