class Apartment
  attr_reader :number,
              :monthly_rent,
              :bathrooms,
              :bedrooms,
              :renter,
              :building

  def initialize(hash)
    @number = hash[:number]
    @monthly_rent = hash[:monthly_rent]
    @bathrooms = hash[:bathrooms]
    @bedrooms = hash[:bedrooms]
    @renter = nil
    @building = nil
  end

  def add_renter(renter)
    @renter = renter
    @building.renters << renter.name if building != nil
    @building.total_rented_units
  end

  def belongs_to(building)
    @building = building
  end
end
