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
SizeType.create(size_id: 66, disk: 20, memory: 512, cpu: 1, cost_per_month: 5.0)
SizeType.create(size_id: 63, disk: 30, memory: 1, cpu: 1, cost_per_month: 10.0)
SizeType.create(size_id: 62, disk: 40, memory: 2, cpu: 2, cost_per_month: 20.0)
SizeType.create(size_id: 64, disk: 60, memory: 4, cpu: 2, cost_per_month: 40.0)
SizeType.create(size_id: 65, disk: 80, memory: 8, cpu: 4, cost_per_month: 80.0)
SizeType.create(size_id: 61, disk: 160, memory: 16, cpu: 8, cost_per_month: 160.0)
SizeType.create(size_id: 60, disk: 320, memory: 32, cpu: 12, cost_per_month: 320.0)
SizeType.create(size_id: 70, disk: 480, memory: 48, cpu: 16, cost_per_month: 480.0)
SizeType.create(size_id: 69, disk: 640, memory: 64, cpu: 20, cost_per_month: 640.0)
SizeType.create(size_id: 68, disk: 960, memory: 96, cpu: 24, cost_per_month: 960.0)

RegionType.delete_all
RegionType.create(region_id: 1, name: "New York 1", slug: "nyc1")
RegionType.create(region_id: 3, name: "San Francisco 1", slug: "sfo1")
RegionType.create(region_id: 4, name: "New York 2", slug: "nyc2")
RegionType.create(region_id: 5, name: "Amsterdam 2", slug: "ams2")
