require 'test_helper'

class InterviewDecoratorTest < ActiveSupport::TestCase
  def setup
    @interview = Interview.new.extend InterviewDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
