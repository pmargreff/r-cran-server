class CreateDependencies < ActiveRecord::Migration[7.0]
  def change
    create_table :dependencies do |t|
      t.string :name
      t.string :version

      t.timestamps
    end

    add_index :dependencies, [:name, :version], unique: true

    create_table :packages_dependencies, id: false do |t|
      t.belongs_to :package
      t.belongs_to :dependency
    end
  end
end
