require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./customer.rb')
require_relative('./screening.rb')

class Screening

  attr_accessor :screening_time, :capacity
  attr_reader :id

  def initialize(options)
    @screening_time = options['screening_time']
    @capacity = options['capacity'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = 'INSERT INTO screenings (screening_time, capacity) VALUES ($1, $2) RETURNING id'
    values = [@screening_time, @capacity]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE screenings SET (screening_time, capacity) = ($1, $2) WHERE id = $3'
    values = [@screening_time, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM screenings'
    SqlRunner.run(sql)
  end

  def self.most_popular_film_screening()
    sql = 'SELECT films.title, screening_time, count(screening_time) AS amount
          FROM screenings
          INNER JOIN tickets
          ON tickets.screening_id = screenings.id
          INNER JOIN films
          ON tickets.film_id = films.id
          GROUP BY screening_time, films.title
          ORDER BY amount DESC
          LIMIT 1'
    result = SqlRunner.run(sql)
    return result.to_a
  end

  def book_ticket()
    @capacity -= 1
    self.update()
  end

end
