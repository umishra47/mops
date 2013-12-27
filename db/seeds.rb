# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

InstanceType.delete_all
InstanceType.create(name: 't1.micro', memory: 0.615, cost: 0.020)
InstanceType.create(name: 'm1.small', memory: 1.7, cost: 0.060)
InstanceType.create(name: 'm1.medium', memory: 3.75, cost: 0.120)