module Api
  module V1
    class FriendsController < Api::V1Controller
      def index
        load_friends
      end

      def show
        load_friend
      end

      def fetch
        find_and_load_friend
        add_friend
        render 'show', status: :ok
      end

      private

      def load_friends
        @friends ||= friend_scope.page(params[:page]).decorate
      end

      def load_friend
        @friend ||= friend_scope.find(params[:id]).decorate
      end

      def find_and_load_friend
        @friend ||= User.where(mobile: friend_params[:mobile]).first_or_create(friend_params)
      end

      def add_friend
        current_user.friendships.where(friend: @friend).first_or_create
      end

      def build_friend
        @friend ||= friend_scope.new.decorate
        @friend.attributes = friend_params
      end

      def save_friend
        @friend.save
      end

      def friend_scope
        current_user.friends
      end

      def friend_params
        friend_params = params[:friend]
        friend_params ? UserParams.permit(friend_params) : {}
      end

      class UserParams
        def self.permit(params)
          params.permit(:name, :mobile)
        end
      end
    end
  end
end
