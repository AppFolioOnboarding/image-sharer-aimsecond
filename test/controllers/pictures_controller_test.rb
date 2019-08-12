require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @picture = Picture.create!(name: 'Alice',
                               link: 'https://robohash.org/32M.png?set=set4',
                               tag_list: 'cat, animal, existing_tag')
  end

  def test_new
    get new_picture_path

    assert_response :ok
    assert_select 'form'
  end

  def test_index
    get pictures_path

    assert_response :ok
    assert_select 'h1', 'Image Uploaded'
    assert_select 'img', Picture.all.count
  end

  def test_index__filtered_by_existing_tag
    get '/tagged?tag=existing_tag'

    assert_response :ok
    assert_select 'img', 1

    Picture.create!(name: 'Alice_2',
                    link: 'https://robohash.org/64M.png?set=set4',
                    tag_list: 'cat, animal, existing_tag')

    get '/tagged?tag=existing_tag'

    assert_response :ok
    assert_select 'img', 2
  end

  def test_index__filtered_by_non_existing_tag
    get '/tagged?tag=no_such_tag'

    assert_response :ok
    assert_select 'img', 0
  end

  def test_index__filtered_by_empty_tag
    get '/tagged?tag='

    assert_response :ok
    assert_select 'img', Picture.all.count
  end

  def test_show
    get picture_path(@picture.id)

    assert_response :ok
    assert_select 'p', "Name:\n  Alice"
  end

  def test_create__succeed
    assert_difference('Picture.count', 1) do
      picture_params = { name: 'Dog', link: 'https://robohash.org/66M.png?set=set4', tag_list: 'dog, animal' }
      post pictures_path, params: { picture: picture_params }
    end

    assert_redirected_to picture_path(Picture.last.id)
  end

  def test_create__fail_unresolvable_url
    assert_no_difference('Picture.count') do
      picture_params = { name: 'Google', link: 'google.com', tag_list: 'website, company' }
      post pictures_path, params: { picture: picture_params }
    end

    assert_response :unprocessable_entity
    assert_equal 'URL host cannot be resolved', flash[:info]
  end

  def test_create__fail_no_remote_image
    assert_no_difference('Picture.count') do
      picture_params = { name: 'Google', link: 'https://www.google.com', tag_list: 'website, company' }
      post pictures_path, params: { picture: picture_params }
    end

    assert_response :unprocessable_entity
    assert_equal 'Given URL is not returning an image', flash[:info]
  end

  def test_destroy
    assert_difference('Picture.count', -1) do
      delete picture_path(@picture.id)
    end

    assert_redirected_to pictures_path
  end
end
