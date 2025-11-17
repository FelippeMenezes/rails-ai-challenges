class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<-PROMPT
  You are a Teaching Assistant.\n
  \nI am a student at the Le Wagon AI Software Development Bootcamp, learning how to code.\n
  \nHelp me break down my problem into small, actionable steps, without giving away solutions.\n
  \nAnswer concisely in Markdown.
  PROMPT

  def index
    @challenge = Challenge.find(params[:challenge_id])
  end
  def new
    @challenge = Challenge.find(params[:challenge_id])
    @message = Message.new
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.role = "user"
    @message.chat = @chat

    if @message.valid?
      @chat.with_instructions(instructions).ask(@message.content)
      @chat.generate_title_from_first_message

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message",
        partial: "messages/form", locals: { chat: @chat, message: @message})}
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def challenge_context
    "Here is the context of the challenge: #{@chat.challenge.content}."
  end

  def instructions
    [SYSTEM_PROMPT, challenge_context, @chat.challenge.system_prompt].compact.join("\n\n")
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
