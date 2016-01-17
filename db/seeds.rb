# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Category.create([{name: 'Одяг', color: 1}, {name: 'Харчі та побут', color: 2},
                   {name: 'Грошова допомога', color: 3}, {name: 'Медикаменти', color: 4},
                   {name: 'Іграшки', color: 5}, {name: 'Зброя', color: 6},
                   {name: 'Екіпірування', color: 7},
                   {name: 'Апаратура', color: 8}, {name: 'Освіта', color: 1}])

