require 'spec_helper'

module OpenSKOS
  describe Concept do
    before(:each) do
      OpenSKOS.url = "http://www.example.com/"
    end
    
    describe ".find" do
      before(:each) do
        @find_concepts_url = OpenSKOS.url + "api/find-concepts"
        stub_request(:get, Regexp.new(@find_concepts_url)).to_return(:body => '<?xml version="1.0" encoding="UTF-8"?><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:openskos="http://openskos.org/xmlns#" openskos:numFound="0" openskos:start="0" openskos:maxScore="0"></rdf:RDF>')
      end
      
      it "requires base URL to have been set" do
        OpenSKOS.url = nil
        expect { OpenSKOS::Concept.find("test") }.to raise_error(OpenSKOS::Errors::URLError, /The OpenSKOS instance URL has not been set/)
      end
      
      it "accepts URI as argument" do
        uri = URI.parse(@find_concepts_url + "concept/1234")
        OpenSKOS::Concept.find(uri)
        expect(a_request(:get, @find_concepts_url + "?id=#{uri.to_s}")).to have_been_made.once
      end
      
      it "accepts string UUID as argument" do
        uuid = "0a39cbfc-a491-75f8-60b2-6b50418e299d"
        OpenSKOS::Concept.find(uuid)
        expect(a_request(:get, @find_concepts_url + "/#{uuid}")).to have_been_made.once
      end
      
      it "accepts string query as argument" do
        OpenSKOS::Concept.find("test")
        expect(a_request(:get, @find_concepts_url + "?q=test")).to have_been_made.once
      end
      
      it "requires UUID, URI or query string" do
        expect { OpenSKOS::Concept.find(:q => "test") }.to raise_error(ArgumentError, /Expected URI, UUID or query/)
      end
        
      it "accepts additional query params"
      
      it "does not need authentication" do
        expect { OpenSKOS::Concept.find("test") }.not_to raise_error
      end
      
      context "when JSON format specified" do
        before(:each) do
          WebMock.reset!
          stub_request(:get, Regexp.new(@find_concepts_url)).to_return(:body => '{"response":{"numFound":0,"start":0,"maxScore":0,"docs":[]}}')
        end
        
        it "requests JSON from API" do
          OpenSKOS::Concept.find("test", :format => "json")
          expect(a_request(:get, @find_concepts_url + "?format=json&q=test")).to have_been_made.once
        end
        
        it "returns parsed JSON object" do
          expect(OpenSKOS::Concept.find("test", :format => "json")).to be_a(Hash)
        end
      end
      
      context "when no format specified" do
        it "returns RDF/XML" do
          expect(OpenSKOS::Concept.find("test")).to be_a(Nokogiri::XML::Document)
        end
      end
    end
  end
end
