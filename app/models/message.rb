class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }
  #④Messageモデルのコールバックを定義し、
  #データが作成されたら非同期でブロードキャスト処理を実行。
  #トランザクションをコミットしたあとでブロードキャストしないと、
  #他のクライアントからデータが見えない恐れあり。
end
