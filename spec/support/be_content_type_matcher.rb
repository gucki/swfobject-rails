RSpec::Matchers.define :be_content_type do |expected|
  match do |actual|
    actual.respond_to?(:content_type) && actual.content_type == expected
  end
  
  failure_message_for_should do |actual|
    "expected #{actual.try(:content_type)} to equal #{expected}"
  end
end
