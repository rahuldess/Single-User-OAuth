require 'uri'

module SingleUserOauth::Header
  extend self

  UNWANTED_HEADER_KEYS = [:request_method, :base_url]

  def create(keys)
    @keys = keys
    key_length = required_keys.length - 1

    required_keys.each_with_index.with_object("OAuth ") do |((key,value), index), obj|
      obj << url_encode(key)
      obj << "="
      obj << "\""
      obj << url_encode(value)
      obj << "\""
      unless index == key_length
        obj << ","
        obj << " "
      end
    end
  end

  private

  def required_keys
    @required_keys ||= @keys.reject{ |key| self::UNWANTED_HEADER_KEYS.include?(key) }
  end

  def url_encode(item)
    SingleUserOauth::Utilities.url_encode(item)
  end

end
