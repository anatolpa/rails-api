class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :operation
      t.string  :status
      t.string  :params
      t.string  :result
      t.references :user, index: true, foreign_key: true
      t.references :image, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
