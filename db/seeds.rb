# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ProductType.delete_all
ProductType.create(name: 't1.micro', memory: 0.615, cost_per_month: 30)
ProductType.create(name: 'm1.small', memory: 1.7, cost_per_month: 70)
ProductType.create(name: 'm1.medium', memory: 3.75, cost_per_month: 135)

SizeType.delete_all
SizeType.create(size_id: 63, name: 'Basic', disk: 30, memory: 1, cpu: 1, cost_per_month: 20.0)
SizeType.create(size_id: 62, name: 'Small', disk: 40, memory: 2, cpu: 2, cost_per_month: 50.0)
SizeType.create(size_id: 64, name: 'Business', disk: 60, memory: 4, cpu: 2, cost_per_month: 90.0)

RegionType.delete_all
RegionType.create(region_id: 1, name: "New York 1", slug: "nyc1")
RegionType.create(region_id: 3, name: "San Francisco 1", slug: "sfo1")
RegionType.create(region_id: 4, name: "New York 2", slug: "nyc2")
RegionType.create(region_id: 5, name: "Amsterdam 2", slug: "ams2")
