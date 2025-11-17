class ChatsController < ApplicationController
  def index
    @challenge = Challenge.find(params[:challenge_id])
    @chats = current_user.chats.where(challenge_id: @challenge)
    @chat = Chat.new
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    @chat = Chat.new(title: "Untitled", model_id: "gpt-4.1-nano")
    @chat.challenge = @challenge
    @chat.user = current_user
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render :index
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new

    if Rails.env.development?
      @input_tokens = @chat.messages.pluck(:input_tokens).compact.sum
      @output_tokens = @chat.messages.pluck(:output_tokens).compact.sum
      @context_window = RubyLLM.models.find(@chat.model_id).context_window
    end
  end
end
