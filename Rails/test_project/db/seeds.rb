# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Superhero.destroy_all
Superhero.create(name: "Superman", secret_identity: "Clark Kent", power: 200)
Superhero.create(name: "Powdered toast man", secret_identity: "Tom Toast", power: 160)
Superhero.create(name: "Spiderman", secret_identity: "Peter Parker", power: 78)
