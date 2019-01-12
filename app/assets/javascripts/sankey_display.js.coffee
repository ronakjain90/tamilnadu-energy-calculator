class SankeyDisplay
 
  constructor: () ->

  # Below is the slider html. Needs no changes.
  html = """
         <div class="slider_wrap">
         <h3 id="year_head"> Flows in the Indian Energy System for the year 2050 </h3>
         <div class="toggle_radio">
         <input type="radio" class="toggle_option" id="0_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" id="1_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" id="2_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" id="3_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" id="4_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" id="5_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" id="6_toggle" name="toggle_option">
         <input type="radio" class="toggle_option" checked id="7_toggle" name="toggle_option">

         <label for="0_toggle"><p>2015</p></label>
         <label for="1_toggle"><p>2020</p></label>
         <label for="2_toggle"><p>2025</p></label>
         <label for="3_toggle"><p>2030</p></label>
         <label for="4_toggle"><p>2035</p></label>
         <label for="5_toggle"><p>2040</p></label>
         <label for="6_toggle"><p>2045</p></label>
         <label for="7_toggle"><p>2050</p></label>

         <div class="toggle_option_slider">
         </div>
         </div>
         """

  updateNavBar: () ->
    $('li.nav-item a.active').removeClass('active')
    $('li.nav-item:nth-child(4) a').addClass('active')

  updateResults: (pathway) ->
    @updateNavBar()
    @setup() unless @s?

    #curyear is the variable that holds the current year. Defaults to 2050 unless explicitly changed elsewhere.
    @curyear = 2050 unless @curyear?
    data = pathway.sankey[window.twentyfifty.views.sankey.curyear]
    #alert data

    if @drawn == true
      @s.updateData(data)
      @s.redraw()
    else
      @s.setData(data)
      @s.draw()
      @drawn = true
    max_y = @s.boxes['losses'].b()
    @s.redraw()
    if $('#sankey').height() < max_y
      $('#sankey').height(max_y)
      @s.r.setSize($('#sankey').width(),max_y)
      #@s.redraw()

  teardown: () ->
    $('#results').empty()
    $('#slider-wrap').empty()

    @s = null

  setup: () ->
    return false if @s?
    document.getElementById("results").style.width = "100%"
    #$('#results').append("<h3 class='sankeytitle'></h3>")
    $('#results').append(html)
    $('#results').append("<div id='sankey'></div>")
    document.getElementById("pathway_box").style.display = "block"
    document.getElementById("classic_controls").style.display = "block"
    document.getElementById("display_table").style.display = "none"
    document.getElementById("print_div").style.display = "none"
    document.getElementById("warning").style.display = "none"
    $('#warning').empty()
    window.snky = @s = new Sankey()

    @s.stack(0, [
      "Small Hydro",
      "Electricity Imports",
      "Solar",
      "Wind",
      "Hydro",
      "Nuclear",
      "Coal Production",
      "Coal Imports",
      "Coal Supply",
      "Oil Production",
      "Oil Imports",
      "Oil Supply",
      "Gas Production",
      "Gas Imports",
      "Gas Supply",
      "Agricultural Waste/ Energy Crops",
      "Municipal Waste",
      "Suppressed Electricity Demand",
    ])

    @s.stack(1, [
      "Offshore Wind",
      "Onshore Wind",
    ], "Wind")


    @s.stack(1, ["Coal"], "Coal Production")
    @s.stack(1, ["Oil"], "Oil Production")
    @s.stack(1, ["Natural Gas"], "Gas Production")

    @s.stack(1, ["Bio-Conversion"],  "Agricultural Waste/ Energy Crops")



    @s.stack(2, [
      "Solar CSP",
      "Solar PV",
      "Distributed Solar PV",
      "Solar Water Heater",
    ], "Electricity Imports")

    @s.stack(2, ["Solid"], "Coal")
    @s.stack(2, ["Liquid"], "Oil")
    @s.stack(2, ["Gas"], "Natural Gas")

    @s.stack(3, [
      "Thermal Generation",
    ], "Nuclear")


    @s.stack(4, [
      "Electricity Grid",
      "Off Grid Renewables",
      "Back-up Electricity"
    ])

    @s.stack(5, [
      "Hydrogen",
    ], "Electricity Grid")

    @s.stack(6, [
      "Cooking",
      "Commercial Buildings",
      "Residential Buildings",
      "Passenger Transport",
      "Freight Transport",
      "Industry",
      "Agriculture",
      "Over Generation/Exports",
      "T&D Losses",
      "Losses"
    ])
    
    # Nudge Losses to the bottom
    @s.nudge_boxes_callback = () ->
      this.boxes["losses"].y =  this.boxes["municipal waste"].b() - this.boxes["losses"].size()

    @s.setColors({
      "Coal Production":"#8F6F38",
      "Coal":"#8F6F38",
      "Coal Imports":"#8F6F38",

      "Oil Production":"#A99268",
      "Oil":"#A99268",
      "Oil Imports":"#A99268",

      "Gas Production":"#DDD4C4",
      "Natural Gas":"#DDD4C4",
      "Gas Imports":"#DDD4C4",

      #"Solar":"#F6FF00",
      "Solar":"#e5bd60",
      "Solar CSP":"#e5bd60",
      "Solar PV":"#e5bd60",
      "Distributed Solar PV":"#e5bd60",
      "Solar Water Heater":"#e5bd60",

      "Agriculture Waste/ Energy Crops":"#30FF00",
      "Bio-Conversion":"#30FF00",
      "Municipal Waste":"#30FF00",

      "Solid":"#557731",
      "Liquid":"#7D9763",
      #"Gas":"#BCC2AD",
      "Gas":"#999285",

      #"Electricity grid":"#8f0000",
      "Electricity grid":"#f44545",
      "Thermal Generation":"#159285",
      #"Thermal Generation":"#CCEEFF",
      "Nuclear":"#E2ABDB",


      #"Electricity Imports":"#CCEEFF",
      "Electricity Imports":"#154c85",
      #"Wind":"#C7E7E6",
      "Wind":"#154c85",
      "Onshore Wind":"#154c85",
      "Offshore Wind":"#154c85",
      "Small Hydro":"#8f0000",

      "Over Generation/Exports":"#CCEEFF",
      "T&D Losses":"#FF6FCF"
    })

    @s.nudge_colours_callback = () ->
      #@recolour(@boxes["Losses"].left_lines,"#ddd")
      #@recolour(@boxes["T&D Losses"].left_lines,"#ddd")
      #@recolour(@boxes["Electricity Grid"].left_lines,"#CCEEFF")

    pixels_per_TWh = $('#sankey').height() / 10000

    @s.y_space = 25 #Math.round(1000 * pixels_per_TWh)
    @s.right_margin = 250
    @s.left_margin = 150
   
    @s.convert_flow_values_callback = (flow) ->
      return flow * pixels_per_TWh # Pixels per TWh

    @s.convert_flow_labels_callback = (flow) ->
      return Math.round(flow)
    
    @s.convert_box_value_labels_callback = (flow) ->
      return (""+Math.round(flow)+" TWh/y")

    # We inserted the html. Most of the following css is to make the slider work, and map 0-7 to 2012-2050
    # This also updates the text on the title
    $(".toggle_option_slider").css "left", 7 * 100
    $(".toggle_option").click ->
      myyear = $(this).attr("id").split("_")[0]
      $(".toggle_option_slider").css "left", myyear * 100
      myyear = myyear*5 + 2015
      $('#year_head').text "Flows in the Indian Energy System for the year " + myyear
      window.twentyfifty.views.sankey.curyear = myyear
      # TRIED a synchronous call for the data, still no luck.
      $.ajax
        url: window.location.pathname.split("/").slice(0, 3).join("/") + "/data"
        dataType: "json"
        async: false
        success: (data) ->
          #alert data.sankey[window.twentyfifty.views.sankey.curyear]
          #alert window.twentyfifty.views.sankey.curyear
          window.snky.updateData(data.sankey[window.twentyfifty.views.sankey.curyear])
          window.snky.redraw()
          #window.sankeydata = data
          #alert(sankeydata.sankey[window.twentyfifty.views.sankey.curyear])
          #window.twentyfifty.views["sankey"].updateResults sankeydata
          return

    return
    

window.twentyfifty.views['sankey'] = new SankeyDisplay
