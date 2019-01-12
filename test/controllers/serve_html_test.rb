require_relative '../../application'
require_relative '../test_helper'

class ServeHTMLTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Application.new
  end

  def test_root
    get '/'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_primary_energy_pathways
    get '/pathways/41101144111111120443122441010222202222222211202220222022222/primary_energy_chart'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_electricity_pathways
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/electricity'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_energy_security_pathways
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/energy_security'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_energy_flow_pathways
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/sankey'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_land_requirement_pathways
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/map'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_grid_balancing_summer_pathways
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/grid_balancing_summer'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_total_cost_pathways
    get '/pathways/22202222222222220222222222012222202222222211202220222022222/total_cost'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_maystory_pathways
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/my_story'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

  def test_assumptions_pathways
    get '/pathways/22202222222222220222222222012222202222222211202220222022222/assumptions'
    assert_equal true, last_response.body.include?('Create your own pathway')
  end

end