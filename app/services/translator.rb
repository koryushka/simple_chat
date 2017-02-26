require 'net/http'
class Translator

  attr_accessor :message

  def initialize(message:)
    @message = message
  end

  def execute
    response = http_request(uri)
    message.content = get_message_from(response.body) if response.is_a? Net::HTTPSuccess
    message
  end

  def get_message_from response
    response.scan(/<p>([^<>]*)<\/p>/).flatten.first.squish
  end

  def uri
    SimpleChat::Application::TRANSLATOR_URI
  end

  def params
    {
      'w' => message.content,
      'd' => message.dialect
    }
  end

  def dialect
    Message.dialects.invert.except(5)[message.dialect]
  end

  def http_request(uri)
    url = URI.parse(uri)
    url.query = URI.encode_www_form(params)
    req = Net::HTTP::Get.new(url.to_s)
    Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  end

end
