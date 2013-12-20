RSpec::Matchers.define :have_content do |expected|
  match do |actual|
    actual.respond_to?(:body) && actual.body.include?(expected)
  end
end