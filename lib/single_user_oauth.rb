require "single_user_oauth/version"
require "single_user_oauth/keys"
require "single_user_oauth/header"
require "single_user_oauth/signature"
require "single_user_oauth/utilities"

module SingleUserOauth
  extend self
  extend SingleUserOauth::Keys

  PERMITTED_KEYS  = [ :request_method,
                      :requested_url,
                      :query_params,
                      :oauth_consumer_key,
                      :oauth_token,
                      :oauth_consumer_secret,
                      :oauth_access_secret
                    ]

  def generate_header(params)
    @params        = params.size.zero? ? {} : params
    @oauth_header  = SingleUserOauth::Header.create(header_params)
  end

  private

  def oauth_signature_string
    SingleUserOauth::Signature.create(signature_params)
  end

  def header_params
    signature_params.merge(oauth_signature: oauth_signature_string)
  end

  def signature_params
    @signature_params ||= permitted_params.merge(default_keys)
  end

  def permitted_params
    @params.select do |key|
      PERMITTED_KEYS.include?(key)
    end
  end

  def default_keys
    {
      oauth_nonce: nonce,
      oauth_signature_method: signature_method,
      oauth_timestamp: timestamp,
      oauth_version: version
    }
  end

end
