require File.expand_path(__dir__) + '/image_card.rb'
module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :pictures

      collection :pictures, locator: '.js-images', item_locator: '.js-image', contains: ImageCard do
        def view!
          show_button.node.click
          stale!
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('Add New Image')
        window.change_to(NewPage)
      end

      def showing_image?(url: nil, tags: nil)
        pictures.each do |picture|
          return true if picture.url == url && (tags.nil? || picture.tags == tags)
        end
        false
      end

      def clear_tag_filter!
        # TODO
      end
    end
  end
end
