class RoomChannel < ApplicationCable::Channel
  #サーバーサイドの処理を受け持つチャンネル
  def subscribed
    # ConsumerがこのChannelのSubscriberになると
    # このコードが呼び出される。
    # stream_from "some_channel"
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! message: data['message'], user_id: current_user.id, room_id: params['room']
  end
  #②speakアクションが呼ばれたらmessageをデータベースに保存
  
end
