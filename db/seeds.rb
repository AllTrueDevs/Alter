#Create Categories
  Category.create([{name: 'Одяг', color: 1}, {name: 'Харчі та побут', color: 2},
                   {name: 'Грошова допомога', color: 3}, {name: 'Медикаменти', color: 4},
                   {name: 'Іграшки', color: 5}, {name: 'Зброя', color: 6},
                   {name: 'Екіпірування', color: 7},
                   {name: 'Апаратура', color: 8}, {name: 'Освіта', color: 1}])

#Create Users
  user = User.new(
      :name                  => "First Admin",
      :email                 => "first@admin.com",
      :role                  => "admin",
      :password              => "12345678",
      :password_confirmation => "12345678"
  )
  user.skip_confirmation!
  user.save!

  user = User.new(
      :name                  => "Second Admin",
      :email                 => "second@admin.com",
      :role                  => "moderator",
      :password              => "12345678",
      :password_confirmation => "12345678"
  )
  user.skip_confirmation!
  user.save!

  user = User.new(
      :name                  => "Third Admin",
      :email                 => "third@admin.com",
      :password              => "12345678",
      :password_confirmation => "12345678"
  )
  user.skip_confirmation!
  user.save!

  user = User.new(
      :name                  => "Fourth Admin",
      :email                 => "fourth@admin.com",
      :role                  => "banned",
      :password              => "12345678",
      :password_confirmation => "12345678"
  )
  user.skip_confirmation!
  user.save!

