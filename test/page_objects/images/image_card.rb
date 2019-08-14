module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      collection :tag_list, locator: '.js-image-tag_list', item_locator: '.js-image-tag' do
        element :tag
      end

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
        # TODO
      end
    end
  end
end
