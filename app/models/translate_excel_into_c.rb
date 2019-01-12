begin
  require 'excel_to_code'
rescue LoadError
  puts "You need to install excel_to_code, try sudo gem install excel_to_code or possibly sudo gem21 install excel_to_code"
  exit
end

# This needs to be changed when the spreadsheet changes
def setup(command)
  command.excel_file = "model.xlsx"
  command.output_directory = '.'
  command.output_name = 'model'

  command.cells_that_can_be_set_at_runtime = {"Control" => (5.upto(63).to_a.map {|r| "e#{r}"})}

  command.cells_to_keep = {
    # The names, limits, 10 worders, long descriptions
    "Control" => (5.upto(63).to_a.map {|r| ["d#{r}", "f#{r}", "h#{r}", "i#{r}", "j#{r}", "k#{r}", "l#{r}", "m#{r}", "bp#{r}", "bq#{r}", "br#{r}", "bs#{r}"]}).flatten,
    "CostAbsolute" => :all,
    "Land Use" => :all,
    "Flows" => :all,
    "Dispatch" => :all,
    "Charts" => :all,
    "My Story" => :all,
  }

  # Add the version number
  command.cells_to_keep["Control"] << "m1"

  # Add the example pathways
  rows = (4..63).to_a
  ('n'..'z').to_a.push('aa', 'ab').each do |column|
    rows.each do |row|
      command.cells_to_keep["Control"].push("#{column}#{row}")
    end
  end

  command.create_makefile = false
  command.create_rakefile = false

  command.actually_compile_code = true
  command.actually_run_tests = true
end

def translate_excel_into_ruby
  command = ExcelToC.new
  setup(command)
  command.go!
end

def create_a_test_for_ruby
  command = ExcelToTest.new
  setup(command)
  command.actually_run_tests = true
  command.go!
end

def change_last_modified_date
  File.open('model_version.rb', 'w') do |f|
    f.puts "def Model.last_modified_date() @last_modified_date ||= Time.utc(*#{Time.now.to_a}); end"
  end
end

translate_excel_into_ruby
change_last_modified_date
