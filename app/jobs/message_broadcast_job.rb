class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message) #⑤ブロードキャストを実行
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: message }
  end
  #renderer.renderで
  #コントローラ以外の場所でビューをレンダリングできる。
end
