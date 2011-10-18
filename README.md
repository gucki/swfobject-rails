Rails 3.1 Integration for SWFObject
===================================

This gem integrates [SWFObject](http://code.google.com/p/swfobject/) with the Rails 3.1 asset pipeline.


Installation
------------

Just add it to your `Gemfile`:

``` ruby
gem "swfobject-rails"
```


Quick Start
-----------

Add to your `application.js`:

``` javascript
//= require swfobject
```

Place your SWFs you want to incude somewhere in the rails 3.1 assets directories (ex. app/assets/swfs/...).

swfobject-rails includes a helper for generating static embed code, `#swf_tag`:

``` erb
<%= swf_tag "video", :id => "my_video", :params => { :loop => true }, :flashvars => { :debug => true } do %>
  <p>You should download the latest Flash player!</p>
<% end %>
```

This would generate the following HTML:

``` html
<object id="my_video" name="my_video" width="100%" height="100%" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
  <param name="movie" value="/assets/video.swf" />
  <param name="wmode" value="transparent" />
  <param name="loop" value="true" />
  <param name="allowfullscreen" value="true" />
  <param name="allowscriptaccess" value="always" />
  <param name="flashvars" value="debug=true" />
  <!--[if !IE]>-->
    <object data="/assets/video.swf" width="100%" height="100%">
      <param name="wmode" value="transparent" />
      <param name="loop" value="true" />
      <param name="allowfullscreen" value="true" />
      <param name="allowscriptaccess" value="always" />
      <param name="flashvars" value="debug=true" />
      <!--<![endif]-->
        <p>You should download the latest Flash player!</p>
      <!--[if !IE]>-->
    </object>
  <!--<![endif]-->
</object>
<script type="text/javascript">
  swfobject.registerObject("my_video", "9.0.0", "/assets/expressInstall.swf");
</script>
```


Updating
--------

When new versions swfobject are released, simply update the gem to the latest version.
