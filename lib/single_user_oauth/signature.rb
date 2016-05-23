require 'openssl'
require 'base64'
require 'uri'
require 'erb'

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
    base_string = ""
    base_string << @request_method
    base_string << '&'
    base_string << url_encode( @request_url)
    base_string << '&'
    base_string << url_encode(percent_encode_params)
  end

  def signing_key
    singing_key = ""
    singing_key << url_encode(@consumer_secret)
    singing_key << '&'
    singing_key << url_encode(@access_secret)
  end

  def calc_signature
    Base64.encode64(hmac_sha1).chomp.gsub(/\n/, '')
  end

  def hmac_sha1
    OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, signing_key, signature_base_string)
  end

  def url_encode(item)
    ERB::Util.url_encode(item)
  end

  def percent_encode_params
    @options.reject{ |key| UNWANTED_HEADER_KEYS.include?(key) }.collect do |key, value|
      unless (value.is_a?(Hash) || value.is_a?(Array)) && value.empty?
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end
    end.compact.sort! * '&'
  end

end
