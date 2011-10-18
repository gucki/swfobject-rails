require "spec_helper"

describe "SWFObject Assets" do
  describe "GET swfobject.js" do
    before  { get "/assets/swfobject-full.js" }
    subject { response }
    it      { should be_ok }
    it      { should be_content_type("text/javascript") }
    it      { should have_content("var swfobject = function() {") }
  end
  
  describe "GET swfobject.min.js" do
    before  { get "/assets/swfobject-min.js" }
    subject { response }
    it      { should be_ok }
    it      { should be_content_type("text/javascript") }
    it      { should have_content("var swfobject=function(){") }
  end
  
  describe "GET expressInstall.swf" do
    before  { get "/assets/expressInstall.swf" }
    subject { response }
    it      { should be_ok }
    it      { should be_content_type("application/x-shockwave-flash") }
  end
end
