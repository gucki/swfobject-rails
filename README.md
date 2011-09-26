Rails 3.1 Integration for swfobject
==

This gem integrates [swfobject](http://code.google.com/p/swfobject/) with the Rails 3.1 asset pipeline.


Install
--

Just add it got your Gemfile:

  gem swfobject-rails


Quick Start
--

Add to your application.js:

    //= require swfobject

Place your SWFs you want to incude somewhere in the rails 3.1 assets directories (ex. app/assets/swfs/...).

In your view you can now do:

    <%= swf_tag "video" %>


Updating
--
When new versions swfobject are released, simply update the gem to the latest version.

