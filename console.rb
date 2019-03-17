require('pry-byebug')
require_relative('./models/ticket')
require_relative('./models/customer')
require_relative('./models/film')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new( {'name' => 'Riker', 'funds' => '200'} )
customer2 = Customer.new( {'name' => 'Picard', 'funds' => '500'} )
customer3 = Customer.new( {'name' => 'Data', 'funds' => '600'} )
customer4 = Customer.new( {'name' => 'Troi', 'funds' => '400'} )
customer5 = Customer.new( {'name' => 'Worf', 'funds' => '900'} )
customer1.save()
customer2.save()
customer3.save()
customer4.save()
customer5.save()

film1 = Film.new( {'title' => 'Generations', 'price' => '10'} )
film2 = Film.new( {'title' => 'Wrath of Khan', 'price' => '30'} )
film3 = Film.new( {'title' => 'In Search of Spock', 'price' => '20'} )
film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new( {'customer_id' => customer1.id, 'film_id' => film1.id} )
ticket2 = Ticket.new( {'customer_id' => customer2.id, 'film_id' => film1.id} )
ticket3 = Ticket.new( {'customer_id' => customer3.id, 'film_id' => film2.id} )
ticket4 = Ticket.new( {'customer_id' => customer4.id, 'film_id' => film2.id} )
ticket5 = Ticket.new( {'customer_id' => customer5.id, 'film_id' => film1.id} )
ticket6 = Ticket.new( {'customer_id' => customer5.id, 'film_id' => film2.id} )

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()

# customer1.name = 'LaForge'
# customer1.update()
#
# film1.title = 'The Undiscovered Country'
# film1.update()
#
# ticket1.customer_id = customer2.id
# ticket1.update()

# film1.find_customers_by_id()
# customer5.find_booked_films()

# binding.pry
# nil
