require 'openssl'

module SingleUserOauth::Keys
  extend self

  private

  def nonce
    @nonce ||= OpenSSL::Random.random_bytes(16).unpack('H*')[0]
  end

  def signature_method
    "HMAC-SHA1".freeze
  end

  def timestamp
    @timestamp ||= Time.now.to_i.to_s
  end

  def version
    "1.0".freeze
  end

end
