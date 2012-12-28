# encoding: utf-8
module SwfobjectHelper
  def swf_path(source)
    asset_path(source)
  end

  def swf_tag(name, options = {})
    width = height = nil
    if options[:size]
      width, height = options[:size].split("x")
    else
      width = options.delete(:width)
      height = options.delete(:height)
    end

    if options[:flashvars]
      # we need to urlencode flashvars, see question 9 at
      # http://code.google.com/p/swfobject/wiki/faq
      flashvars = {}
      options[:flashvars].each_pair do |k, v|
        flashvars[CGI.escape(k.to_s)] = CGI.escape(v.to_s)
      end
    else
      flashvars = options[:flashvars]
    end

    code = "swfobject.embedSWF('%s', '%s', '%s', '%s', '%s', '%s', %s, %s, %s, %s);" % [
      options[:public_path] || swf_path("#{name}.swf"),
      options[:dom_id] || name,
      width,
      height,
      options[:version] || "9.0.0",
      swf_path("expressInstall.swf"),
      flashvars.to_json,
      options[:params].to_json,
      options[:attributes].to_json,
      options[:callback] ? options[:callback] : "null",
    ]

    javascript_tag(code)
  end

  def swfobject(*args)
    swf_tag(*args)
  end
end

