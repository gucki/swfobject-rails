module SwfobjectHelper
  # Default options for the #swfobject helper.
  DEFAULT_OPTIONS = {
    :width   => "100%",
    :height  => "100%",
    :version => "9.0.0",
    :partial => "shared/swfobject"
  }
  
  # Default <param> tags.
  DEFAULT_PARAMS = {
    :allowfullscreen   => true,
    :allowscriptaccess => "always",
    :wmode             => "transparent"
  }
  
  # Generates static embed HTML using the method recommend here:
  # http://code.google.com/p/swfobject/wiki/documentation
  #
  # +file+ is the path to the SWF. Alternate content can be used
  # by passing a +block+
  #
  # Other Options:
  #
  #   * <tt>:id</tt>        - The ID on the outer <object> tag. Defaults to
  #                           an underscored version of the filename.
  #   * <tt>:width</tt>     - The width of the SWF. Defaults to "100%".
  #   * <tt>:height</tt>    - The height of the SWF. Defaults to "100%".
  #   * <tt>:version</tt>   - The minimum version of the Flash player required.
  #                           Defaults to "9.0.0".
  #   * <tt>:params</tt>    - A hash of parameters to configure the SWF. Will be used
  #                           to generate <param> tags. Defaults to DEFAULT_PARAMS.
  #   * <tt>:flashvars</tt> - A hash of variables to send to the flash file. Will
  #                           be sent using an encoded value in a <param> tag.
  #
  def swf_tag(file, options = {}, &block)
    options.reverse_merge! DEFAULT_OPTIONS
    
    # Get path to asset
    file = swf_path file
    
    # Extract params from options
    params = options.delete(:params) || {}
    params.reverse_merge! DEFAULT_PARAMS
    
    # Extract flashvars and add to params
    if flashvars = options.delete(:flashvars)
      params[:flashvars] = flashvars.to_query
    end
    
    # Generate ID from file if necessary
    id = options.delete(:id) || File.basename(file, File.extname(file)).underscore
    
    # Extract other specific options
    version     = options.delete :version
    partial     = options.delete :partial
    alt_content = options.delete :alternate_content
    alt_content = capture(&block) if block_given?
    
    # And finally, render the partial
    render partial,
      :file              => file,
      :id                => id,
      :version           => version,
      :params            => params,
      :attributes        => options,
      :alternate_content => alt_content
  end
  alias :swfobject :swf_tag
  
  # Computes the path to a SWF file in the assets pipeline.
  # If the +source+ filename has no extension, .swf will be appended (except for explicit URIs)
  # Full paths from the document root will be passed through.
  # Used internally by #swf_tag to build the path to the SWF file.
  #
  # ==== Examples
  #
  #   swf_path "file"                            # => /assets/file.swf
  #   swf_path "dir/file.swf"                    # => /assets/dir/file.swf
  #   swf_path "/dir/file.swf"                   # => /dir/file.swf
  #   swf_path "http://www.example.com/file"     # => http://www.example.com/file
  #   swf_path "http://www.example.com/file.swf" # => http://www.example.com/file.swf
  #
  def swf_path(source)
    asset_path source, :ext => "swf"
  end
end

