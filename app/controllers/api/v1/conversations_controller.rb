module Api
  module V1
    class ConversationsController < Api::V1Controller
      def index
        load_conversations
      end

      def show
        load_conversation
      end

      def create
        build_conversation
        save_conversation
        render 'show', status: :created
      end

      def destroy
        load_conversation
        return render 'show', status: :bad_request if @conversation.single?
        @conversation.destroy
        render 'show', status: :ok
      end

      private

      def load_conversations
        @conversations ||= conversation_scope.page(params[:page]).decorate
      end

      def load_conversation
        @conversation ||= conversation_scope.find(params[:id]).decorate
      end

      def build_conversation
        @conversation ||= conversation_scope.new.decorate
        @conversation.attributes = conversation_params
      end

      def save_conversation
        @conversation.save
      end

      def conversation_scope
        current_user.conversations
      end

      def conversation_params
        conversation_params = params[:conversation]
        conversation_params ? ConversationParams.permit(conversation_params) : {}
      end

      class ConversationParams
        def self.permit(params)
          params.permit(:mode)
        end
      end
    end
  end
end
