class User
  class Friendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :friend, class_name: 'User'
    after_create do
      User::Friendship.create(user: friend, friend: user) if User::Friendship.where(user: friend, friend: user).empty?
    end
  end
end
