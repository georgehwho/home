class Building
  attr_reader :units,
              :renters,
              :rented_units

  def initialize
    @units = []
    @renters = []
    @rented_units = []
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

  def total_rented_units
    @rented_units = []
    renters.each do |renter|
      units.each do |unit|
        @rented_units << unit if unit.renter != nil && unit.renter.name == renter
      end
    end
  end

  def renter_with_highest_rent
    @rented_units.max_by { |unit| unit.monthly_rent }.renter
  end

  def units_by_number_of_bedrooms
    hash = units.group_by { |unit| unit.bedrooms }
    hash.transform_values! do |v|
      v[0] = v[0].number
    end
  end
end
