# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

cat1 = Cat.create(birth_date: '2020/01/10', color: 'grey', name: 'Missy', sex: 'F', description: 'Cat1 description.')
cat2 = Cat.create(birth_date: '2021/01/05', color: 'orange', name: 'Whiskers', sex: 'M', description: 'Cat2 description.')
cat3 = Cat.create(birth_date: '2023/02/19', color: 'mix', name: 'Speedy', sex: 'F', description: 'Cat3 description.')
cat4 = Cat.create(birth_date: '2017/10/12', color: 'black', name: 'Jumper', sex: 'F', description: 'Cat4 description.')
cat5 = Cat.create(birth_date: '2018/02/22', color: 'white', name: 'Paws', sex: 'F', description: 'Cat5 description.')