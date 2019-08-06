class Picture < ApplicationRecord
  attr_accessor :name, :link

  validates :name, presence: true
  validates :link, presence: true
  validate :validates_image_url

  private

  def validates_image_url
    url = resolve_url(link)
    errors.add(:link, 'URL host cannot be resolved') unless url.present?
    errors.add(:link, 'Given URL is not returning an image') unless remote_image_exists?(url)
  end

  def resolve_url(img_url)
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
