require 'rails_helper'

RSpec.describe Micropost, type: :model do

def setup
  @user = users(:roberto)
  # This code is not idiomatically correct.
  @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
end

test "should be valid" do
  assert @micropost.valid?
end

test "user id should be present" do
  @micropost.user_id = nil
  assert_not @micropost.valid?
  end
end

# RSpec.describe Micropost, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
