class Picture < ApplicationRecord
  attr_accessor :name, :link

  validates :name, presence: true
  validates :link, presence: true
  validate :validates_image_url

  private

  def validates_image_url
    errors.add(:link, 'Invalid URL') unless remote_image_exists?(img_url_valid?(@link))
  end

  def img_url_valid?(img_url)
    url = URI.parse(img_url)
    return url if url.host
  rescue URI::Error
    nil
  end

  # return true if img_url will return image type resource. else return false.
  def remote_image_exists?(img_url)
    return false unless img_url

    resource_type = Net::HTTP.get_response(img_url)['Content-Type']
    resource_type&.start_with?('image')
  rescue StandardError
    false
  end
end
