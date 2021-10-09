class ApplicationController < ActionController::API
  include FirebaseUtils    

  private                                                        
    # tokenが正規のものであれば、デコード結果を返す
    # そうでなければfalseを返す
    def authenticate_firebase_id_token
      # authenticate_with_http_tokenは、HTTPリクエストヘッダーに
      # Authorizationが含まれていればブロックを評価する。
      # 含まれていなければnilを返す。
      authenticate_with_http_token do |token, options|
        begin
          decoded_token = FirebaseUtils::Auth.verify_id_token(token)
        rescue => e
          logger.error(e.message)
          false
        end
      end
    end
end
