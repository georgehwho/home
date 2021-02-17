class Building
  attr_reader :units,
              :renters

  def initialize
    @units = []
    @renters = []
  end

  def add_unit(unit)
    @units << unit
    unit.belongs_to(self)
  end

  def add_renter(renter)
    @renters << renter.name
  end

  def average_rent
    total_rent = units.reduce(0) { |memo, apartment| memo += apartment.monthly_rent }
    total_rent / units.size.to_f
  end
end
