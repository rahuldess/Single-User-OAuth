require 'openssl'
require 'base64'
require 'uri'

module SingleUserOauth::Signature
  extend self

  UNWANTED_HEADER_KEYS = [:request_method, :base_url]

  def create(options)
    @options          = options
    @request_method   = @options.fetch(:request_method, '').upcase
    @request_url      = @options.fetch(:base_url, '')
    @consumer_secret  = @options.fetch(:oauth_consumer_secret, '')
    @access_secret    = @options.fetch(:oauth_access_secret, '')

    calc_signature
  end

  def signature_base_string
    encode(@request_method, @request_url, percent_encode_params)
  end

  def signing_key
    encode(@consumer_secret, @access_secret)
  end

  def encode(*args)
    string = ""
    args.each_with_index do |key, index|
      string << url_encode(key)
      string << '&' unless index == args.length-1
    end
    string
  end

  def calc_signature
    Base64.encode64(hmac_sha1).chomp.gsub(/\n/, '')
  end

  def hmac_sha1
    OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, signing_key, signature_base_string)
  end

  def url_encode(item)
    SingleUserOauth::Utilities.url_encode(item)
  end

  def percent_encode_params
    @options.reject{ |key| UNWANTED_HEADER_KEYS.include?(key) }.collect do |key, value|
      unless (value.is_a?(Hash) || value.is_a?(Array)) && value.empty?
        "#{escape(key.to_s)}=#{escape(value.to_s)}"
      end
    end.compact.sort! * '&'
  end

  def escape(item)
    CGI.escape(item)
  end

end
