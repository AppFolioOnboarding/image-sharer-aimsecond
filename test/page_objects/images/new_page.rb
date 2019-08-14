module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_picture
      path :pictures

      form_for :picture do
        element :name
        element :link
        element :tag_list
        element :submit_button, locator: 'input[type="submit"]'
      end

      def create_image!(name: nil, url: nil, tags: nil)
        picture.name.set name unless name.blank?
        picture.link.set url unless url.blank?
        picture.tag_list.set tags unless tags.blank?

        submit_button.node.click
        stale!
        window.change_to(ShowPage, NewPage)
      end
    end
  end
end
