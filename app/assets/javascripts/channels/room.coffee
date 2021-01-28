document.addEventListener 'turbolinks:load', ->
  #クライアント側の処理を受け持つチャンネル
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#messages').data('room_id') },
    connected: ->
      #接続がつながった時に実行されるコールバック関数
    disconnected: ->
      #接続の解除が起こった時
    received: (data) ->
      $('#messages').append data['message']
      #③サーバーからデータを受け取った時の
      #動きを定義

    speak: (message) ->
      @perform 'speak', message: message
      #①サーバーサイドのspeakアクションを呼び出し
      #messageをパラメーターとして渡す

  $('#chat-input').on 'keypress', (event) ->
    if event.keyCode is 13 #return = send
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()
      #room.show.htmlのフォームで
      #リターンキーが押された時（メッセージが送信された時）
      #room_channelのspeakアクション実行