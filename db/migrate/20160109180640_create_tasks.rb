class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :stime
      t.string :ftime
      t.string :time
      t.string :description

      t.timestamps null: false
    end
  end
end
