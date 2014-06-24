module OpenSKOS
  module Errors
    ##
    # Raised if an OpenSKOS query is attempted without the URL being set.
    #
    class URLError < StandardError
      def initialize(msg = nil)
        msg ||= <<-MSG
URL Error.

The OpenSKOS instance URL has not been set.

Set the URL with:

  OpenSKOS.url = "http://www.example.com/"
        MSG
        super(msg)
       end
    end
  end
end
