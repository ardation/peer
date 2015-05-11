class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :mode, default: 0, null: false

      t.timestamps null: false
    end
  end
end
