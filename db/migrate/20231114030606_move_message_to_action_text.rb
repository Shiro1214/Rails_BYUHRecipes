class MoveMessageToActionText < ActiveRecord::Migration[7.1]
  def change
    Comment.all.find_each do |comment|
      comment.update(content: comment.message)
    end
    remove_column :comments, :message
  end
end
