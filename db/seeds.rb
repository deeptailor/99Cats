# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
(1..4).each do |num|
  u = User.new(user_name:num.to_s)
  u.password = 'password'
  u.save!
end

(1..4).each do |num|
  Cat.create!(name: num.to_s, birth_date: Date.today, color:Cat::CAT_COLORS.sample,
  user_id: 1+(num/2), sex: 'M')
end

CatRentalRequest.create!(cat_id: 1, user_id: 3, start_date:Date.yesterday, end_date:Date.tomorrow)
CatRentalRequest.create!(cat_id: 3, user_id: 4, start_date:Date.yesterday, end_date:Date.tomorrow)
