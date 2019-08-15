module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :picture

      element :tag_list
      element :destroy_button, locator: '.js-destroy-btn'
      element :back_button, locator: '.js-back-btn'

      def image_url
        node.find('img')[:src]
      end

      def tags
        tag_list.text.split(' ')
      end

      def delete
        destroy_button.node.click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        destroy_button.node.click
        alert = node.driver.browser.switch_to.alert
        alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        back_button.node.click
        stale!
        window.change_to(IndexPage)
      end
    end
  end
end
