class CreateConversationMessages < ActiveRecord::Migration
  def change
    create_table :conversation_messages do |t|
      t.text :text
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
