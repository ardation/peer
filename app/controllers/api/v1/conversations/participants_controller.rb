module Api
  module V1
    module Conversations
      class ParticipantsController < Api::V1Controller
        def index
          load_participants
        end

        def show
          load_participant
        end

        def create
          build_participant
          save_participant
          render 'show', status: :created
        end

        def destroy
          load_participant
          @participant.destroy
          render 'show', status: :ok
        end

        private

        def load_participants
          @participants ||= participant_scope.page(params[:page]).try(:decorate)
        end

        def load_participant
          @participant ||= participant_scope.find(params[:id]).try(:decorate)
        end

        def build_participant
          @participant ||= participant_scope.new.try(:decorate)
          @participant.attributes = participant_params
        end

        def save_participant
          @participant.save
        end

        def participant_scope
          conversation_scope.participants
        end

        def conversation_scope
          current_user.conversations.find(params[:conversation_id])
        end

        def participant_params
          participant_params = params[:participant]
          participant_params ? ParticipantParams.permit(participant_params) : {}
        end

        class ParticipantParams
          def self.permit(params)
            params.permit(:mode)
          end
        end
      end
    end
  end
end
