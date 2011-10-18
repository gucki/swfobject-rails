require "spec_helper"

describe SwfobjectHelper do
  describe "#swf_tag" do
    it "returns with static embedingd HTML" do
      output = helper.swf_tag "myContent"
      
      doc    = Nokogiri::HTML(output)
      object = doc.at_css "body > object"
      object["id"].should     == "my_content"
      object["name"].should   == "my_content"
      object["width"].should  == "100%"
      object["height"].should == "100%"
      
      doc.at_css("body > object > param[name='movie']")["value"].should             == "/assets/myContent.swf"
      doc.at_css("body > object > param[name='allowfullscreen']")["value"].should   == "true"
      doc.at_css("body > object > param[name='allowscriptaccess']")["value"].should == "always"
      doc.at_css("body > object > param[name='wmode']")["value"].should             == "transparent"
      
      inner = doc.at_css "body > object object"
      inner["data"].should   == "/assets/myContent.swf"
      inner["width"].should  == "100%"
      inner["height"].should == "100%"
      
      inner.at_css("param[name='allowfullscreen']")["value"].should   == "true"
      inner.at_css("param[name='allowscriptaccess']")["value"].should == "always"
      inner.at_css("param[name='wmode']")["value"].should             == "transparent"
      
      script = doc.at_css "script"
      script.content.strip.should == 'swfobject.registerObject("my_content", "9.0.0", "/assets/expressInstall.swf");'
    end
    
    it "returns with custom options" do
      output = helper.swf_tag "myContent",
        :id      => "video_player",
        :width   => 640,
        :height  => 360,
        :version => "10"
        
      doc    = Nokogiri::HTML(output)
      object = doc.at_css "body > object"
      object["id"].should     == "video_player"
      object["name"].should   == "video_player"
      object["width"].should  == "640"
      object["height"].should == "360"
      
      inner = doc.at_css "body > object object"
      inner["width"].should  == "640"
      inner["height"].should == "360"
      
      script = doc.at_css "script"
      script.content.strip.should == 'swfobject.registerObject("video_player", "10", "/assets/expressInstall.swf");'
    end
      
    it "returns with custom params" do
      output = helper.swf_tag "myContent", :params => {
        :loop    => true,
        :wmode   => "opaque",
        :bgcolor => "#666666"
      }
      
      doc = Nokogiri::HTML(output)
      doc.at_css("body > object > param[name='allowfullscreen']")["value"].should   == "true"
      doc.at_css("body > object > param[name='allowscriptaccess']")["value"].should == "always"
      doc.at_css("body > object > param[name='wmode']")["value"].should             == "opaque"
      doc.at_css("body > object > param[name='loop']")["value"].should              == "true"
      doc.at_css("body > object > param[name='bgcolor']")["value"].should           == "#666666"
      
      inner = doc.at_css "body > object object"
      inner.at_css("param[name='allowscriptaccess']")["value"].should == "always"
      inner.at_css("param[name='wmode']")["value"].should             == "opaque"
      inner.at_css("param[name='loop']")["value"].should              == "true"
      inner.at_css("param[name='bgcolor']")["value"].should           == "#666666"
    end
    
    it "returns with alternate content" do
      output = helper.swf_tag("myContent") { content_tag :p, "You should download Flash!" }
      
      doc         = Nokogiri::HTML(output)
      alt_content = doc.at_css "body > object object p"
      alt_content.content.strip.should == "You should download Flash!"
    end
    
    it "returns with flashvars" do
      output = helper.swf_tag "myContent", :flashvars => {
        :skin => "/flash/playerSkin.swf",
        :image => "/images/thumbnail.jpg"
      }
      
      doc = Nokogiri::HTML(output)
      doc.at_css("body > object > param[name='flashvars']")["value"].should == "image=%2Fimages%2Fthumbnail.jpg&skin=%2Fflash%2FplayerSkin.swf"
      
      inner = doc.at_css "body > object object"
      inner.at_css("param[name='flashvars']")["value"].should == "image=%2Fimages%2Fthumbnail.jpg&skin=%2Fflash%2FplayerSkin.swf"
    end
    
    it "returns with custom attributes" do
      output = helper.swf_tag "myContent", :class => "video", :style => "display: none"
      
      doc    = Nokogiri::HTML(output)
      object = doc.at_css "body > object"
      object["class"].should == "video"
      object["style"].should == "display: none"
      
      inner = doc.at_css "body > object object"
      inner["class"].should == "video"
      inner["style"].should == "display: none"
    end
  end
  
  describe "#swf_path" do
    it "generates paths to SWF files in the asset pipeline" do
      helper.swf_path("myContent").should                       == "/assets/myContent.swf"
      helper.swf_path("expressInstall").should                  == "/assets/expressInstall.swf"
      helper.swf_path("dir/file").should                        == "/assets/dir/file.swf"
      helper.swf_path("/dir/file").should                       == "/dir/file.swf"
      helper.swf_path("http://www.example.com/file").should     == "http://www.example.com/file"
      helper.swf_path("http://www.example.com/file.swf").should == "http://www.example.com/file.swf"
    end
  end
end
