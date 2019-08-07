# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
image_generator_link = 'https://robohash.org/'
image_setting = '.png?set=set4'
name_list = %w[Nick Thomas Alice Bob Rich
               Ali Eric David Hoffman Bill
               Amanda Laura Alfred Juan Peter
               Paul Charles Maxwell Turing Albert]
name_list.each do |name|
  Picture.create(name: "Cat_#{name}", link: "#{image_generator_link}#{name}#{image_setting}")
end
