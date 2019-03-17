require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./customer.rb')
require_relative('./screening.rb')

class Screening

  attr_accessor :screening_time, :capacity, :film
  attr_reader :id

  def initialize(options)
    @screening_time = options['screening_time']
    @capacity = options['capacity']
    @film = options['film']
    @id = options['id'].to_i if options['id']
  end

end
