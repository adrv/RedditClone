class Post < ActiveRecord::Base
  belongs_to :user
  
  acts_as_votable
  acts_as_tree

  def link
    "/posts/#{self.id}"
  end

  def reply?
    self.parent
  end
end
