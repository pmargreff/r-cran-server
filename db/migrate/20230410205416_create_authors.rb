class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end

    create_table :packages_authors, id: false do |t|
      t.belongs_to :package
      t.belongs_to :author
    end
  end
end
