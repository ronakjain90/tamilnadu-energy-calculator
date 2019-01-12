require_relative '../../application'
require_relative '../test_helper'

describe Model do
  before do
    @model = ModelResult.new
  end

  describe "Test ModelResult" do

    it "instance method calculate_pathway respond with hash" do
      assert @model.calculate_pathway('22202222222222220222222222012222202222222211202220222022222').is_a?(Hash)
    end

    it "class method calculate_pathway respond with hash" do
      assert ModelResult.calculate_pathway('22202222222222220222222222012222202222222211202220222022222').is_a?(Hash)
    end

    it 'other instance methods responds with hash' do
      @model.pathway = {}
      assert @model.sankey_table.is_a?(Hash)
      assert @model.primary_energy_tables.is_a?(Hash)
      assert @model.electricity_tables.is_a?(Hash)
      assert @model.demand_year.is_a?(Hash)
      assert @model.supply_year.is_a?(Hash)
      assert @model.dependency.is_a?(Hash)
      assert @model.emissions_do_nothing.is_a?(Hash)
      assert @model.land_do_nothing.is_a?(Hash)
      assert @model.land_table.is_a?(Hash)
      assert @model.emissions_absolute.is_a?(Hash)
      assert @model.emissions_percapita.is_a?(Hash)
      assert @model.import_costs.is_a?(Hash)
      assert @model.increamental_costs.is_a?(Hash)
      assert @model.year_increamental_costs.is_a?(Hash)
      assert @model.increamental_table.is_a?(Hash)
      assert @model.import_proportions.is_a?(Hash)
      assert @model.get_costs.is_a?(Hash)
      assert @model.grid_balancing.is_a?(String)
      assert @model.my_story.is_a?(Hash)
      assert @model.global_assumption.is_a?(Hash)
    end
  end
end