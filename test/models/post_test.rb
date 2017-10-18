# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'sample 1' do
    raw_data = File.open 'samples/post1.md'
    post = Post.create raw: raw_data.read
    assert_equal 'The Rain in Spain', post.title
    assert_equal 'rain-in-spain', post.url
    assert_equal "<p>The rain in Spain falls mainly in the plain.</p>\n", post.html
    assert_equal ['mainly-in-the-plain'], post.aliases
    assert_equal %w[rain spain], post.tags
    assert post.published
  end
end
