class TotalCost

  constructor: () ->
    @ready = false
  
  setup: () ->
    document.getElementById("display_table").style.width = "12%"
    document.getElementById("results").style.width = "66%"
    document.getElementById("warning").style.width = "22%"
    $('#energy_container').empty()
    $('#results').append("<div id='energy_container'></div>")
    target = $('#energy_container')
    target.append("<div id='container_costs_in_context' class=''></div>")

    document.getElementById("pathway_box").style.display = "block"
    document.getElementById("classic_controls").style.display = "block"
    document.getElementById("display_table").style.display = "block"
    document.getElementById("print_div").style.display = "none"
    document.getElementById("warning").style.display = "block"
    $('#display').empty()
    $('#display').append("<h5>Explore</h5><ul class='subnav'><li><a href='#' id='energy-subnav-1' class='btn btn-dark selected' onclick='twentyfifty.switchView(\"total_cost\")'>Total Energy Cost</a></li><li><a href='#' id='energy-subnav-2' class='btn btn-dark' onclick='twentyfifty.switchView(\"costs\")'>Cost Overview</a></li><li><a href='#' id='energy-subnav-3' class='btn btn-dark' onclick='twentyfifty.switchView(\"costsYear\")'>Differential Cost</a></li></ul>")

    #$('#warning').append("<h5>Warning</h5>")

    @chart_costs_context = new Highcharts.Chart(

      chart:
        renderTo: "container_costs_in_context"
        height: 250

      title:

        text: "Total energy system costs"

      legend:
        enabled: true

      exporting:
        enabled: false

      xAxis: {
       
        labels: formatter: ->

          switch @value
            when 2015
              return 2015
            when 2020
              return 2020
            when 2025
              return 2025
            when 2030
              return 2030
            when 2035
              return 2035
            when 2040
              return 2040
            when 2045
              return 2045
            when 2050
              return 2050

      },
      tooltip:  
        enabled: true
        crosshairs: true
        shared: true
        valueDecimals: 0
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 5
          y: 30
  
      
	

      plotOptions:
        line:
          marker:
            enabled: false
          dataLabels: 
            enabled: true,
            color: '#000',
            formatter: () ->
              Highcharts.numberFormat(this.y,0)
          

      yAxis:
        labels: formatter: ->
          return Math.round(this.value/1) + ''

        title: {
          style: {
            fontWeight: "bold",
            color: "#154c85",
            fontSize: "10px"
          },
          align: "high",
          rotation: 0,
          textAlign: "left",
          x: 0,
          y: -15,
          text: "INR Billion"
        }  


      series: []
    )
  
  teardown: () ->
    $('#results').empty()
    $('#energy_container').empty()

    @chart_costs_context = null

  updateNavBar: () ->
    $('li.nav-item a.active').removeClass('active')
    $('li.nav-item:nth-child(6) a').addClass('active')

  updateResults: (@pathway) ->
    @updateNavBar()
    @setup() unless @chart_costs_context

    titles = ["counterfact_low","counterfact_high"]
    i = 0
    data = []
    data_counter = []
    data_year = [2015,2020,2025,2030,2035,2040,2045,2050]
    for name in titles 
      data[i] = @pathway['costs'][name]['Total']
      i++

    j = 0
    while j < data[0].length
      data_counter.push([data_year[j], data[0][j] , data[1][j]]) 
      j++

    if @chart_costs_context.series[0]?
      @chart_costs_context.series[0].setData(data_counter,false)
    else
      @chart_costs_context.addSeries({name:'Range of costs for the Determined Effort Pathway', data:data_counter, color: '#FF6600', type: 'arearange', fillOpacity: 0.7, lineWidth: 0},false)


    title = ['counterfact_point', 'user_point']
    chart_name = ['Point Cost- Determined Effort', 'Point Cost- Your Pathway']
    chart_color = ['#800000', '#336600']
    i=1
    data_p = []
    for name in title
      data = @pathway['costs'][name]['Total']
      j = 0
      while j < data.length
        data_p.push([data_year[j], data[j]])
        j++

      if @chart_costs_context.series[i]?
        @chart_costs_context.series[i].setData(data_p,false)
      else
        @chart_costs_context.addSeries({name: chart_name[i-1], data:data_p, type: 'line', color:chart_color[i-1]},false) 
      data_p = []
      i++ 


    @chart_costs_context.series[1].color = "#ff0000"


    @chart_costs_context.redraw()      

    document.getElementById("warning").innerHTML="<h6>Compare the cost of your chosen pathway with the Determined Effort pathway costs</h6><p>The orange band on the graph represents the range of costs that can pan out for the Determined Effort pathway generated by the tool.</br>The “Determined Effort Point Cost” line represents the average cost trajectory that the Determined Effort pathway will follow.</br>The “Your Pathway Point Cost” line represents the average cost of your pathway panning out till the year 2050.</p>"


window.twentyfifty.views["total_cost"] = new TotalCost
