require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "image model" do
    img = Image.new
    assert_not img.save
  end
end
