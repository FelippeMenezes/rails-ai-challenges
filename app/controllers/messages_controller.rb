class MessagesController < ApplicationController

  before_action :set_challenge, only: [:index, :new, :create]


  SYSTEM_PROMPT = <<-PROMPT
  You are a Teaching Assistant.\n
  \nI am a student at the Le Wagon AI Software Development Bootcamp, learning how to code.\n
  \nHelp me break down my problem into small, actionable steps, without giving away solutions.\n
  \nAnswer concisely in Markdown.
  PROMPT

  def index
    @messages = @challenge.messages
  end
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(role: "user", content: params[:message][:content], challenge: @challenge)
    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      response = @ruby_llm_chat.with_instructions(instructions).ask(@message.content)
      Message.create(role: "assistant", content: response.content, challenge: @challenge)
      redirect_to challenge_messages_path(@challenge)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def challenge_context
    "Here is the context of the challenge: #{@challenge.content}."
  end

  def instructions
    [SYSTEM_PROMPT, challenge_context, @challenge.system_prompt].compact.join("\n\n")
  end
end
