require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/data_objects/incremental_average'

class IncrementalAverageTest < Minitest::Test

  def test_it_should_initialize_average
    avg = IncrementalAverage.new(5)

    assert_equal 1, avg.count
    assert_equal 5, avg.average
  end

  def test_it_should_initialize_average_nil
    avg = IncrementalAverage.new

    assert_nil avg.average
  end

  def test_it_should_add_sample_if_average_nil
    avg = IncrementalAverage.new

    avg.add_sample(10)

    assert_equal 10, avg.average
  end

  def test_it_should_add_sample_to_average
    avg = IncrementalAverage.new(5)

    avg.add_sample(10)

    assert_equal 2, avg.count
    assert_equal 7.5, avg.average

    avg.add_sample(19)

    assert_equal 11.333333333333334, avg.average
  end
end
