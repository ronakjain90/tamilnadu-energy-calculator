class EnergySecurity

  titles_dependency = ['Coal','Oil','Gas','Overall']

  titles_import_costs = ["Coal","Oil","Gas"]

  setup: () ->
    document.getElementById("results").style.width = "75%"
    target = $('#results')
    target.append("<div id='dependency_chart' class='chart'></div>")
    target.append("<div id='import_proportion_chart' class='chart'></div>")
    target.append("<div id='import_costs_chart' class='chart'></div>")


    document.getElementById("pathway_box").style.display = "block"
    document.getElementById("classic_controls").style.display = "block"
    document.getElementById("results").style.overflow = "inherit"
    document.getElementById("display_table").style.display = "block"
    document.getElementById("print_div").style.display = "none"
    document.getElementById("warning").style.display = "none"
    $('#warning').empty()
    $('#display').empty()
 
    $('#display').append("<h5>Explore</h5><ul class='subnav'><li><a href='#' id='energy-subnav-1' class='selected btn btn-dark' onclick=''>Fossil Fuel</a></li></ul>")

    @dependency_chart = new Highcharts.Chart({
      chart: { renderTo: 'dependency_chart', type: 'line', height: 250, width: 300 },
      title: { text: 'Import Dependence' },
      yAxis: { 
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
          y: -10,
          text: "Percentage"
        },  
        min: 0, 
        max: 100,
        width: 225 },
      xAxis: {
        width: 240,
        value: (148400),
        dashStyle: 'longdashdot'
      },

      legend:{
        itemStyle: { fontSize: '7pt' }
      },

      tooltip:{
        enabled: true,
        formatter: () ->
          "<b>#{this.series.name}</b><br/><b>#{this.x}: #{Highcharts.numberFormat(this.y,0)} % </b>"
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 65
          y: 0
      },

      plotOptions:
        area:
          lineWidth: 0.1

        series:
          states:
            hover:
              enabled: true
              lineWidth: 2
              lineColor: "#6c6c6c"

          events:
            mouseOver: ->
              twentyfifty.highlightLegend "custom-legend0", this.index, true
              Ddata = [
                Highcharts.numberFormat(@yData[0], 0, ",")
                Highcharts.numberFormat(@yData[3], 0, ",")
                Highcharts.numberFormat(@yData[5], 0, ",")
                Highcharts.numberFormat(@yData[7], 0, ",")
              ]
              $("#display-data0 #SeriesName").html this.name
              i = 0

              while i < 8
                $("#display-data0 #SeriesData" + i).html Ddata[i]
                i++
              return

            mouseOut: ->
              twentyfifty.highlightLegend "custom-legend0", this.index, false
              i = 0

              while i < 8
                $("#display-data0 #SeriesData" + i).empty()
                i++
              $("#display-data0 #SeriesName").empty()
              return

      series: []

    })



    @import_costs_chart = new Highcharts.Chart({
      chart: { renderTo: 'import_costs_chart', type: 'column', height: 250, width: 300 },
      title: { text: 'Import Costs' },
      yAxis: { 
        labels: formatter: ->
          return Math.round(this.value/1)        
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
          y: -10,
          text: "INR Trillion / yr"
        }, width: 225, 
        stackLabels: {
          enabled: false,
          style: {
            fontWeight: 'bold',
            color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
        }
      }},

      xAxis:{ width: 240},
      legend:{
        itemStyle: { fontSize: '7pt' }
      },
      tooltip:{
        enabled: true,
        formatter: () ->
          "<b>#{this.series.name}</b><br/><b>#{this.x}: #{Highcharts.numberFormat(this.y,0)} INR Trillion/yr </b>"
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 65
          y: 0
      },


      plotOptions:
        column:
          stacking: 'normal'

        series:
          states:
            hover:
              enabled: true
              lineWidth: 2
              lineColor: "#6c6c6c"

          events:
            mouseOver: ->
              twentyfifty.highlightLegend "custom-legend2", this.index, true
              Ddata = [
                Highcharts.numberFormat(@yData[0], 0, ",")
                Highcharts.numberFormat(@yData[1], 0, ",")
                Highcharts.numberFormat(@yData[2], 0, ",")
                Highcharts.numberFormat(@yData[3], 0, ",")
                Highcharts.numberFormat(@yData[4], 0, ",")
                Highcharts.numberFormat(@yData[5], 0, ",")
                Highcharts.numberFormat(@yData[6], 0, ",")
                Highcharts.numberFormat(@yData[7], 0, ",")
              ]
              $("#display-data2 #SeriesName").html this.name
              i = 0

              while i < 8
                $("#display-data2 #SeriesData" + i).html Ddata[i]
                i++
              return

            mouseOut: ->
              twentyfifty.highlightLegend "custom-legend2", this.index, false
              i = 0

              while i < 8
                $("#display-data2 #SeriesData" + i).empty()
                i++
              $("#display-data2 #SeriesName").empty()
              return

      series: []

    })


    @import_proportion_chart  =  new Highcharts.Chart({
      chart: {
        type: 'column',renderTo: 'import_proportion_chart', height: 250, width: 300 },
      title: { text: 'Oil, Gas & Coal Imports' },

      yAxis: { 
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
          y: -10,
          text: "TWh/yr"
        }, width: 225 },

      xAxis:{ width: 240},
      legend:{
        itemStyle: { fontSize: '7pt' }
      },
      tooltip:{
        enabled: true,
        formatter: () ->
          "<b>#{this.series.name}</b><br/><b>#{this.x}: #{Highcharts.numberFormat(this.y,0)} TWh/yr </b>"
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 65
          y: 0
      },
      plotOptions:
        column:
          stacking: 'normal'

        series:
          states:
            hover:
              enabled: true
              lineWidth: 2
              lineColor: "#6c6c6c"

          events:
            mouseOver: ->
              twentyfifty.highlightLegend "custom-legend1", this.index, true
              Ddata = [
                Highcharts.numberFormat(@yData[0], 0, ",")
                Highcharts.numberFormat(@yData[1], 0, ",")
                Highcharts.numberFormat(@yData[2], 0, ",")
                Highcharts.numberFormat(@yData[3], 0, ",")
                Highcharts.numberFormat(@yData[4], 0, ",")
                Highcharts.numberFormat(@yData[5], 0, ",")
                Highcharts.numberFormat(@yData[6], 0, ",")
                Highcharts.numberFormat(@yData[7], 0, ",")
              ]
              $("#display-data1 #SeriesName").html this.name

              i = 0

              while i < 8
                $("#display-data1 #SeriesData" + i).html Ddata[i]
                i++
              return

            mouseOut: ->
              twentyfifty.highlightLegend "custom-legend1", this.index, false
              i = 0

              while i < 8
                $("#display-data1 #SeriesData" + i).empty()
                i++
              $("#display-data1 #SeriesName").empty()
              return

      series: []

    })

  teardown: () ->

    $('#results').empty()

    @dependency_chart = null
    @import_costs_chart = null
    @import_proportion_chart = null

  updateResults: (@pathway) ->
    @setup() unless @dependency_chart? && @import_costs_chart? && @import_proportion_chart?

    i = 0
    for name in titles_dependency
      data = @pathway['dependency'][name]

      # data contains 0.1 for 10%, so multiply by 100 for charting
      data = ((d*100) for d in data)

      if @dependency_chart.series[i]?
        @dependency_chart.series[i].setData(data,false)
      else
        @dependency_chart.addSeries({name:name,data:data},false)
      i++


    # The fourth in the series is the total, so we want to make it blacker, thicker and more dotted
    # than the other lines
    @dependency_chart.series[3].color = "#000000"
    @dependency_chart.series[3].options.lineWidth = 3
    @dependency_chart.series[3].options.dashStyle = "longdashdot"

    i = 0

    data = @pathway['import_costs']['Total']
    if @import_costs_chart.series[i]?
      @import_costs_chart.series[i].setData(data,false)
    else
      @import_costs_chart.addSeries({type: 'line', name: 'Total',data:data, lineColor: '#000', color: '#000',lineWidth:2,dashStyle:'Dot', shadow: false},false)
    i++

    for name in titles_import_costs
      data = @pathway['import_costs'][name]
      if @import_costs_chart.series[i]?
        @import_costs_chart.series[i].setData(data,false)
      else
          @import_costs_chart.addSeries({name:name,data:data},false)
      i++

    i = 0

    titles_import_proportion = ["Coal", "Oil", "Gas"]

    data = @pathway['import_proportions']['Total']
    if @import_proportion_chart.series[i]?
      @import_proportion_chart.series[i].setData(data,false)
    else
      @import_proportion_chart.addSeries({type: 'line', name: 'Total',data:data, lineColor: '#000', color: '#000',lineWidth:2,dashStyle:'Dot', shadow: false},false)
    i++

    for name in titles_import_proportion
      data = @pathway['import_proportions'][name]

      if @import_proportion_chart.series[i]?
        @import_proportion_chart.series[i].setData(data,false)
      else
        @import_proportion_chart.addSeries({name:name,data:data},false)
      i++


    # **************** Start Custom Legand *****************     
    ChartArr = [
      @dependency_chart.series
      @import_proportion_chart.series
      @import_costs_chart.series
    ]
    optionsArr = [
      @dependency_chart.options.legend
      @import_proportion_chart.options.legend
      @import_costs_chart.options.legend
    ]
    chartIdArr = [
      "#dependency_chart"
      "#import_proportion_chart"
      "#import_costs_chart"
    ]

    # calling common layout of legand

    twentyfifty.callCommon chartIdArr

    # Creating legand
    # Display data of corresponding series on mouse over on legand item
    # On mouse over respective series will highlight and other will fade out
    # Data will display on mouse over on series area 

    L = 0
    K = 0
    charts_id = []
    while L < 3
      chartSeries = []
      chartSeries = ChartArr[L]
      options = optionsArr[L]

      twentyfifty.callLegand options, chartSeries, L, null

      parentElement = $(chartIdArr[L])[0]
      charts_id.push parentElement.children[0].id

      L++

####### .view is a class of 'View All' item in legand list. #######
    i = 0
    $('.view0').click ->

      twentyfifty.ViewAllSeries ChartArr[0], "view0", "viewAll"

      return

    $('.view1').click ->

      twentyfifty.ViewAllSeries ChartArr[1], "view1", "viewAll"

      return

    $('.view2').click ->

      twentyfifty.ViewAllSeries ChartArr[2], "view2", "viewAll"

      return

######### End View  All click function ######################

    $("#"+charts_id[0]).mouseover ->
      $("#custom-legend0").css visibility: "visible"
      $("#custom-legend0").css opacity: "0.9"
    $("#"+charts_id[0]).mouseout ->
      $("#custom-legend0").css visibility: "hidden"
      $("#custom-legend0").css opacity: 0

    $("#"+charts_id[1]).mouseover ->
      $("#custom-legend1").css visibility: "visible"
      $("#custom-legend1").css opacity: "0.9"
    $("#"+charts_id[1]).mouseout ->
      $("#custom-legend1").css visibility: "hidden"
      $("#custom-legend1").css opacity: 0
    
    $("#"+charts_id[2]).mouseover ->
      $("#custom-legend2").css visibility: "visible"
      $("#custom-legend2").css opacity: "0.9"
    $("#"+charts_id[2]).mouseout ->
      $("#custom-legend2").css visibility: "hidden"
      $("#custom-legend2").css opacity: 0

    # **************** End Custom Legand ***************** 

    @dependency_chart.redraw()
    @import_costs_chart.redraw()
    @import_proportion_chart.redraw()




window.twentyfifty.views['energy_security'] = new EnergySecurity


