class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :update, Post, user_id: user.id
      can :destroy, Post do |post|
        post.user_id == user.id && !post.root?
      end
      can :create, Post
    end
  end
end
