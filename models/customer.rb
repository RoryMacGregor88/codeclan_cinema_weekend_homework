require_relative('../db/sql_runner.rb')
require_relative('./ticket.rb')
require_relative('./film.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
    @tickets_bought = 0
  end

  def self.delete_all()
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM customers'
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

  def self.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new(customer) }
    return result
  end

  def save()
    sql = 'INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id'
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM customers where id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def find_booked_films()
    sql = 'SELECT title FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          INNER JOIN customers
          ON tickets.customer_id = customers.id
          WHERE customers.name = $1'
    values = [@name]
    result = SqlRunner.run(sql, values)
    return result.to_a
  end

end