require 'spec_helper'
require 'nokogiri'

describe OpenSKOS do
  before(:each) do
    OpenSKOS.defaults!
  end
  
  describe ".url=" do
    it "sets the base URL" do
      expect { OpenSKOS.url = "http://www.example.com/" }.to change{ OpenSKOS.instance_variable_get(:@url) }.to("http://www.example.com/")
    end
    
    it "strips/adds a trailing slash"
    it "validates URL"
  end
  
  describe ".url" do
    it "gets the base URL" do
      OpenSKOS.instance_variable_set(:@url, "http://www.example.org/")
      expect(OpenSKOS.url).to eq("http://www.example.org/")
    end
    
    it "defaults to nil" do
      expect(OpenSKOS.url).to be_nil
    end
  end
  
  describe ".defaults!" do
    it "sets base URL to its default" do
      OpenSKOS.url = "http://www.example.com/"
      expect { OpenSKOS.defaults! }.to change { OpenSKOS.url }.to(nil)
    end
  end
end
