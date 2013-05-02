# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'

Job.create(
  title:'Web Developer',
  company:'RooMedia',
  location:'New York',
  description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor tincidunt erat, non luctus justo ornare ut. Nunc nec est sapien. Donec a odio tellus. Praesent nisl turpis, convallis a blandit in, congue eu lectus. Vivamus purus lorem, dapibus ac molestie sit amet, luctus in nisi. Nunc imperdiet, eros sit amet imperdiet hendrerit, mi arcu ornare tellus, in tempus lacus velit vel nisl. Pellentesque posuere enim ut justo lacinia suscipit. Praesent molestie lobortis elit, quis ultrices neque cursus sed. Fusce ultrices dictum sem nec fringilla. Aenean quis lacus enim.',
  start_date:Date.new(2008,6,18),
  end_date:Date.new(2008,10,18) 
)