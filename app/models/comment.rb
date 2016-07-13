class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  def user
    User.where(id: user_id).first
  end
end
