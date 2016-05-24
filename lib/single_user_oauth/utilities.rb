require 'erb'

module SingleUserOauth::Utilities
  extend self

  def url_encode(item)
    ERB::Util.url_encode(item)
  end

end
