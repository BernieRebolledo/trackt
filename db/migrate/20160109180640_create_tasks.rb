class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :hours
      t.integer :mins
      t.integer :secs
      t.boolean :time, :default => false
      t.string :description
      t.boolean :status, :default => false
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
