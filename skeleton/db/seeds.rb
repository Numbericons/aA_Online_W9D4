# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


25.times do 
  n = Faker::Creature::Cat.unique.name # "Shadow"
  des = Faker::Quote.famous_last_words
  Cat.create(birth_date: Cat.get_bday, color: Cat.get_color, name: n, 
    sex: Cat.get_sex, description: des)
end