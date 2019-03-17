require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./customer.rb')
require_relative('./screening.rb')

class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def self.all()
    sql = 'SELECT * FROM tickets'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM tickets'
    ticket_data = SqlRunner.run(sql)
    return Ticket.map_items(ticket_data)
  end

  def self.map_items(ticket_data)
    result = ticket_data.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def save()
    sql = 'INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id'
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3'
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # def find_customer_by_id()
  #   sql = 'SELECT customers.name, films.title
  #         FROM tickets
  #         INNER JOIN customers
  #         ON $1 = customers.id
  #         INNER JOIN films
  #         ON $2 = films.id'
  #   values = [@customer_id, @film_id]
  #   return SqlRunner.run(sql, values)
  # end

end
