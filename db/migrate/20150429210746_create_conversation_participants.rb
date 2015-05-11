class CreateConversationParticipants < ActiveRecord::Migration
  def change
    create_table :conversation_participants do |t|
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
