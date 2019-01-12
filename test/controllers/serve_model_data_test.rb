require_relative '../../application'
require_relative '../test_helper'

class ServeHTMLTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Application.new
  end

  def test_model_data_sample_1
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/data'
    assert_equal true, JSON.parse(last_response.body).count.equal?(31)
  end

  def test_model_data_sample_2
    get 'pathways/22202222222222220222222222012222202222222211202220222022222/data'
    assert_equal true, JSON.parse(last_response.body).count.equal?(31)
  end

end