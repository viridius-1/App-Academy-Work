# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Loading Cats..."
Cat.destroy_all 
cat1 = Cat.create(birth_date: '2020/01/10', color: 'grey', name: 'Missy', sex: 'F', description: 'Cat1 description.')
cat2 = Cat.create(birth_date: '2021/01/05', color: 'orange', name: 'Whiskers', sex: 'M', description: 'Cat2 description.')
cat3 = Cat.create(birth_date: '2023/02/19', color: 'mix', name: 'Speedy', sex: 'F', description: 'Cat3 description.')
cat4 = Cat.create(birth_date: '2017/10/12', color: 'black', name: 'Jumper', sex: 'F', description: 'Cat4 description.')
cat5 = Cat.create(birth_date: '2018/02/22', color: 'white', name: 'Paws', sex: 'F', description: 'Cat5 description.')

puts "Loading Cat Rental Requests..."
CatRentalRequest.destroy_all 
#cat1 requests
request1 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2023/05/03', end_date: '2023/05/10', status: 'APPROVED')
request2 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2023/06/01', end_date: '2023/06/10', status: 'PENDING')
request3 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2023/07/01', end_date: '2023/07/10', status: 'DENIED')
request4 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2023/05/01', end_date: '2023/05/05', status: 'PENDING')
request5 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2023/05/02', end_date: '2023/05/15', status: 'PENDING')
request6 = CatRentalRequest.create(cat_id: cat1.id, start_date: '2023/07/05', end_date: '2023/07/12', status: 'PENDING')
#cat2 requests 
request7 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2023/05/03', end_date: '2023/05/10', status: 'APPROVED')
request8 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2023/06/01', end_date: '2023/06/10', status: 'PENDING')
request9 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2023/07/01', end_date: '2023/07/10', status: 'DENIED')
request10 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2023/05/01', end_date: '2023/05/05', status: 'PENDING')
request11 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2023/05/02', end_date: '2023/05/15', status: 'PENDING')
request12 = CatRentalRequest.create(cat_id: cat2.id, start_date: '2023/07/05', end_date: '2023/07/12', status: 'PENDING')
#cat3 requests 
request13 = CatRentalRequest.create(cat_id: cat3.id, start_date: '2023/05/03', end_date: '2023/05/10', status: 'APPROVED')
request14 = CatRentalRequest.create(cat_id: cat3.id, start_date: '2023/06/01', end_date: '2023/06/10', status: 'PENDING')
request15 = CatRentalRequest.create(cat_id: cat3.id, start_date: '2023/07/01', end_date: '2023/07/10', status: 'DENIED')
request16 = CatRentalRequest.create(cat_id: cat3.id, start_date: '2023/05/01', end_date: '2023/05/05', status: 'PENDING')
request17 = CatRentalRequest.create(cat_id: cat3.id, start_date: '2023/05/02', end_date: '2023/05/15', status: 'PENDING')
request18 = CatRentalRequest.create(cat_id: cat3.id, start_date: '2023/07/05', end_date: '2023/07/12', status: 'PENDING')
#cat4 requests 
request19 = CatRentalRequest.create(cat_id: cat4.id, start_date: '2023/05/03', end_date: '2023/05/10', status: 'APPROVED')
request20 = CatRentalRequest.create(cat_id: cat4.id, start_date: '2023/06/01', end_date: '2023/06/10', status: 'PENDING')
request21 = CatRentalRequest.create(cat_id: cat4.id, start_date: '2023/07/01', end_date: '2023/07/10', status: 'DENIED')
request22 = CatRentalRequest.create(cat_id: cat4.id, start_date: '2023/05/01', end_date: '2023/05/05', status: 'PENDING')
request23 = CatRentalRequest.create(cat_id: cat4.id, start_date: '2023/05/02', end_date: '2023/05/15', status: 'PENDING')
request24 = CatRentalRequest.create(cat_id: cat4.id, start_date: '2023/07/05', end_date: '2023/07/12', status: 'PENDING')
#cat5 requests 
request25 = CatRentalRequest.create(cat_id: cat5.id, start_date: '2023/05/03', end_date: '2023/05/10', status: 'APPROVED')
request26 = CatRentalRequest.create(cat_id: cat5.id, start_date: '2023/06/01', end_date: '2023/06/10', status: 'PENDING')
request27 = CatRentalRequest.create(cat_id: cat5.id, start_date: '2023/07/01', end_date: '2023/07/10', status: 'DENIED')
request28 = CatRentalRequest.create(cat_id: cat5.id, start_date: '2023/05/01', end_date: '2023/05/05', status: 'PENDING')
request29 = CatRentalRequest.create(cat_id: cat5.id, start_date: '2023/05/02', end_date: '2023/05/15', status: 'PENDING')
request30 = CatRentalRequest.create(cat_id: cat5.id, start_date: '2023/07/05', end_date: '2023/07/12', status: 'PENDING')