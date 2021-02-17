require 'minitest/autorun'
require 'minitest/pride'
require './lib/building'
require './lib/apartment'
require './lib/renter'

class BuildingTest < Minitest::Test
  def setup
    @building = Building.new
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    @unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    @unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    @renter1 = Renter.new("Aurora")
    @renter2 = Renter.new("Tim")
    @renter3 = Renter.new("Spencer")
    @renter4 = Renter.new('Jessie')
    @renter5 = Renter.new("Max")
  end

  def test_it_exists
    assert_instance_of Building, @building
  end

  def test_it_has_readable_attributes
    assert_equal [], @building.units
    assert_equal [], @building.renters
  end

  def test_it_can_add_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal [@unit1, @unit2], @building.units
  end

  def test_it_can_add_renter_names
    @building.add_renter(@renter1)

    assert_equal ['Aurora'], @building.renters
  end

  def test_it_can_add_renters
    # skip
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit1.add_renter(@renter1)

    assert_equal ['Aurora'], @building.renters

    @unit2.add_renter(@renter2)
    assert_equal ["Aurora", "Tim"], @building.renters
  end

  def test_it_can_find_the_average_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal 1099.5, @building.average_rent
  end

  def test_it_can_find_the_total_amount_of_renters
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)

    assert_equal [], @building.rented_units

    @unit2.add_renter(@renter3)
    assert_equal [@unit2], @building.rented_units
    @unit1.add_renter(@renter4)
    assert_equal [@unit2, @unit1], @building.rented_units
  end

  def test_it_can_find_the_renter_with_the_highest_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter3)
    assert_equal @renter3, @building.renter_with_highest_rent
    @unit1.add_renter(@renter4)
    assert_equal @renter4, @building.renter_with_highest_rent
    @unit3.add_renter(@renter5)
    assert_equal @renter4, @building.renter_with_highest_rent
  end

  def test_it_can_group_units_by_bedrooms
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @building.add_unit(@unit4)

    answer = {
                3 => ["D4" ],
                2 => ["B2", "C3"],
                1 => ["A1"]
              }

    assert_equal answer, @building.units_by_number_of_bedrooms
  end
end
