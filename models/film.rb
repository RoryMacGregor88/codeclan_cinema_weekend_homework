require('pry-byebug')
require_relative('../db/sql_runner.rb')
require_relative('./ticket.rb')
require_relative('./customer.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price']
    @id = options['id'].to_i if options['id']
  end

  def self.delete_all()
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def save()
    sql = 'INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id'
    values = [@title, @price]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE films SET (title, price) = ($1, $2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM films WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM films'
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

  def self.map_items(film_data)
    result = film_data.map { |film| Film.new(film) }
    return result
  end

  def find_customers_by_id()
    sql = 'SELECT * FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          INNER JOIN films
          ON tickets.film_id = films.id
          WHERE films.title = $1'
    values = [@title]
    result = SqlRunner.run(sql, values)
    return Customer.map_items(result)
  end

  def sell_ticket()
    
  end

end
