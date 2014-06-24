require 'rest_client'
require 'nokogiri'
require 'json'

module OpenSKOS
  class Concept
    ##
    # Find concepts from the OpenSKOS instance
    #
    # @param [URI,String] id_or_query The URI or UUID of a single concept, or
    #   a text query for searching concepts.
    # @param [Hash] [params] Additional query parameters to send to the API.
    # @return [Nokogiri::XML::Document] An RDF/XML document containing the API
    #   response.
    # @return [Hash] If `params[:format] == "json"`, the API response parsed
    #   into a {Hash}.
    #
    def self.find(id_or_query, params = {})
      raise Errors::URLError if OpenSKOS.url.nil?
      
      url = OpenSKOS.url + "api/find-concepts"
      
      case id_or_query
      when URI
        params[:id] = id_or_query
      when /\A[0-9a-f]{8}-[0-9a-f]{4}-\d[0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}\Z/ # UUID
        url << "/#{id_or_query.to_s}"
      when String
        params[:q] = id_or_query
      else
        raise ArgumentError, "Expected URI, UUID or query, got: #{id_or_query.class.to_s}"
      end
      
      response = RestClient.get(url, :params => params)
      
      case params[:format]
      when "json"
        JSON.parse(response)
      else
        Nokogiri::XML(response)
      end
    end
  end
end
