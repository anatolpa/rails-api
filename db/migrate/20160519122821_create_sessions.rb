class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, null: false, index: true
      t.string  :token, null: false, default: ""
    end
  end
end
