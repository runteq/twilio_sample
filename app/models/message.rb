class Message < ApplicationRecord
  enum result: { result_ok: 1, result_wait: 2, result_ng: 3, report_to_management: 4 }

  def call
    sid = Rails.application.credentials.dig(:twilio, :sid)
    token = Rails.application.credentials.dig(:twilio, :token)
    from_number = Rails.application.credentials.dig(:twilio, :phone_number)

    client = Twilio::REST::Client.new sid, token
    msg = Twilio::TwiML::VoiceResponse.new do |r|
      r.say voice: 'Alice', language: 'ja-JP', message: '自動告白サービス。告白の行方です。'
      r.pause length: 1
      r.say voice: 'Alice', language: 'ja-JP', message: "#{to_name}様。#{from_name}様よりメッセージがございます。"
      r.pause length: 2
      r.say voice: 'Polly.Takumi', language: 'ja-JP', message: message
      r.say voice: 'Polly.Takumi',  language: 'ja-JP', message: message
      r.pause length: 1
      r.gather action: Rails.application.routes.url_helpers.message_url(id), method: 'POST', numDigits: 1 do |g|
        g.say voice: 'Alice', language: 'ja-JP', message: 'この告白にOKの場合は1を。。。もう一度考える場合は2を。。。ごめんなさいの場合は3を入力してください。'
        r.pause length: 2
        g.say voice: 'Alice', language: 'ja-JP', message: '運営に通報する場合は4を入力してください'
      end
    end

    phone = "+81" + phone_number.gsub('-', '').gsub(/\A0/, '')
    client.calls.create(
      twiml: msg.to_s,
      to: phone,
      from: from_number
    )
  end
end
