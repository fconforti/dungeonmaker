# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

races = YAML.load_file(Rails.root.join('db/seeds/races.yml'))
races.each { |race| Race.where(name: race['name']).first_or_create! }

klasses = YAML.load_file(Rails.root.join('db/seeds/klasses.yml'))
klasses.each { |klass| Klass.where(name: klass['name']).first_or_create!(hit_die: klass['hit_die']) }
