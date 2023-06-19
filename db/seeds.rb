# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

RenderAccount.find_or_create_by!(name: "Personal Account", api_key: "rnd_zJCsYj0R30n0T1PBJp6Lo4OmcELS")
