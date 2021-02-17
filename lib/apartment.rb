require './lib/building'

class Apartment
  attr_reader :number,
              :monthly_rent,
              :bathrooms,
              :bedrooms,
              :renter,
              :belongs_to

  def initialize(hash)
    @number = hash[:number]
    @monthly_rent = hash[:monthly_rent]
    @bathrooms = hash[:bathrooms]
    @bedrooms = hash[:bedrooms]
    @renter = nil
  end

  def add_renter(renter)
    @renter = renter
  end

  def belongs_to(building)
    @belongs_to = building
  end
end
