require_relative 'acceptance_helper'

describe "Home page" do

  include AcceptanceHelper

  it "return 200" do
    visit "/"
    assert_equal 200, page.status_code
  end

  it 'visits_all_other_pages_to_do_regression_test' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    assert page.find('div#results').text.include?('Energy Demand')
  end

  it 'visits_all_energy' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('primary_energy_chart')")
    assert page.find('div#results').text.include?('Energy Demand')
  end

  it 'visits_electricity' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('electricity')")
    assert page.find('div#results').text.include?('Electricity demand')
  end

  it 'visits_energy_security' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('energy_security')")
    assert page.find('div#results').text.include?('Percentage Import Dependence')
  end

  it 'visits_energy_emissions' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('emissions')")
    assert page.find('div#results').text.include?('Total Emissions')
  end

  it 'visits_energy_flows' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('sankey')")
    assert page.find('div#results').text.include?('Flows in the Indian Energy System')
  end

  it 'visits_land_requirements' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('map')")
    assert page.find('div#results').text.include?('Land Footprint')
  end

  it 'visits_grid_balancing' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('grid_balancing_summer')")
    assert page.find('div#results').text.include?('Grid dispatch pattern')
  end

  it 'visits_energy_cost' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('total_cost')")
    assert page.find('div#results').text.include?('energy system costs')
  end

  it 'visits_my_story' do
    visit "/"
    page.find('body .popover .popover-navigation').click_button('End tour')
    page.execute_script("twentyfifty.switchView('my_story')")
    assert page.find('div#results').text.include?('The chosen energy pathway')
  end

end