require 'minitest/autorun'
require 'minitest/pride'
require './lib/apartment'
require './lib/renter'
require './lib/building'

class ApartmentTest < Minitest::Test
  def setup
    @renter1 = Renter.new('Jessie')
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @building = Building.new
  end

  def test_it_exists
    assert_instance_of Apartment, @unit1
  end

  def test_it_has_readable_attributes
    assert_equal 'A1', @unit1.number
    assert_equal 1200, @unit1.monthly_rent
    assert_equal 1, @unit1.bathrooms
    assert_equal 1, @unit1.bedrooms
    assert_nil @unit1.renter
    assert_nil @unit1.building
  end

  def test_it_can_add_a_renter
    @unit1.add_renter(@renter1)
    assert_equal @renter1, @unit1.renter
  end

  def test_it_knows_when_it_belongs_to_a_building
    # skip
    @unit1.belongs_to(@building)
    assert_equal @building, @unit1.building
  end

  def test_it_adds_renter_name_to_building_if_it_belongs_to_a_building
    @unit1.belongs_to(@building)
    @unit1.add_renter(@renter1)
    assert_equal ['Jessie'], @unit1.building.renters
  end
end
