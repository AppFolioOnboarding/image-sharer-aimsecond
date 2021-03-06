module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      collection :tag_list, locator: '.js-image-tag_list', item_locator: '.js-image-tag' do
        element :tag
      end

      element :show_button, locator: '.js-show-btn'

      def url
        node.find('img')[:src]
      end

      def tags
        res = []
        tag_list.each do |tag|
          res.append(tag.text)
        end
        res
      end

      def click_tag!(tag_name)
        target_tag = tag_list.detect { |tag| tag.text == tag_name }
        target_tag.node.click
        stale!
        window.change_to(IndexPage)
      end
    end
  end
end
