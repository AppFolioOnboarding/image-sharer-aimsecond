require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def test_picture__valid
    picture = Picture.new(name: 'apple', link: 'https://robohash.org/H3S.png?set=set4')
    assert picture.valid?
  end

  def test_name__invalid_if_name_is_blank
    picture = Picture.new(name: '', link: 'https://robohash.org/H3S.png?set=set4')
    refute picture.valid?
    assert_equal "can't be blank", picture.errors[:name].first
    picture = Picture.new(name: nil, link: 'https://robohash.org/H3S.png?set=set4')
    refute picture.valid?
    assert_equal "can't be blank", picture.errors[:name].first
  end

  def test_link__invalid_if_link_is_blank
    picture = Picture.new(name: 'apple', link: '')
    refute picture.valid?
    assert_equal "can't be blank", picture.errors[:link].first
    picture = Picture.new(name: 'apple', link: nil)
    refute picture.valid?
    assert_equal "can't be blank", picture.errors[:link].first
  end

  def test_image_url__invalid_if_url_host_cannot_be_resolved
    # TODO: finish the test
    picture = Picture.new(name: 'apple', link: 'www.random_url_blah.com')
    refute picture.valid?
    assert_equal 'URL host cannot be resolved', picture.errors[:link].first
    assert_equal 'Given URL is not returning an image', picture.errors[:link].last
  end

  def test_image_url__invalid_if_resource_is_not_image
    picture = Picture.new(name: 'apple', link: 'https://robohash.org/')
    refute picture.valid?
    assert_equal 'Given URL is not returning an image', picture.errors[:link].first
  end

  def test_image_url__valid_if_resource_is_image
    link = 'https://robohash.org/H3S.png?set=set4'
    picture = Picture.new(name: 'apple', link: link)
    assert picture.valid?
  end
end
