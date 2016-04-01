# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
User.create! [
  { username: "Fiorina", password_digest: "password_1",
    profile: Profile.create!(first_name: "Carly", last_name: "Fiorina", birth_year: 1954, gender: "female") },
  { username: "Trump", password_digest: "password_2",
    profile: Profile.create!(first_name: "Donald", last_name: "Trump", birth_year: 1946, gender: "male") },
  { username: "Carson", password_digest: "password_3",
    profile: Profile.create!(first_name: "Ben", last_name: "Carson", birth_year: 1951, gender: "male") },
  { username: "Clinton", password_digest: "password_4",
    profile: Profile.create!(first_name: "Hillary", last_name: "Clinton", birth_year: 1947, gender: "female") }
]

TodoList.destroy_all
TodoItem.destroy_all
new_due_date = Date.today >> 12
4.times do |i|
  new_list = TodoList.create!(list_name: "list_#{i}", list_due_date: new_due_date,
                              user: User.find_by!(password_digest: "password_#{i + 1}"))
  5.times do |j|
    new_list.todo_items << TodoItem.create!(title: "item_#{j}", description: "description_#{j}", due_date: new_due_date)
  end
end
