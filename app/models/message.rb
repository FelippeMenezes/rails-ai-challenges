class Message < ApplicationRecord
  acts_as_message

  belongs_to :chat

  validate :user_message_limit, if: -> { role == "user" }

  validates :content, presence: true, length: {minimum: 10, max: 1000}, if: -> {role == "user"}
  validates :role, presence: true

  MAX_USER_MESSAGES = 10

  private

  def user_message_limit
    if chat.messages.where(role: "user").count >= MAX_USER_MESSAGES
      errors.add(:base, "You can only send #{MAX_USER_MESSAGES} messages per chat.")
    end
  end
end
