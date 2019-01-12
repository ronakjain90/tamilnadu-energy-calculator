class Electricity

  setup: () ->
    document.getElementById("display_table").style.width = "12%"
    document.getElementById("results").style.width = "75%"
    document.getElementById("warning").style.width = "10%"
    target = $('#results')
    target.append("<div id='demand_chart' class='chart'></div>")
      .append("<div id='supply_chart' class='chart'></div>")
      .append("<div id='electricity_overgeneration' class='chart'></div>")

    document.getElementById("pathway_box").style.display = "block"
    document.getElementById("classic_controls").style.display = "block"
    document.getElementById("display_table").style.display = "block"
    document.getElementById("print_div").style.display = "none"
    document.getElementById("warning").style.display = "block"

    $('#display').empty()

    $('#display').append("<h5>Explore</h5><ul class='subnav'><li><a href='#' id='energy-subnav-1' class='btn btn-dark selected' onclick='twentyfifty.switchView(\"electricity\")'>Demand and Supply</a></li><li><a href='#' id='energy-subnav-2' class='btn btn-dark' onclick='twentyfifty.switchView(\"electricity_analysis\")'>Analysis of Electricity Share</a></li></ul>")


    document.getElementById("results").style.overflow = "inherit"

    @demand_chart = new Highcharts.Chart({
      chart: {renderTo: 'demand_chart', height: 250, width: 295},
      title: {text: 'Electricity demand'},
      tooltip: {
        enabled: true,
        formatter: () ->
          "<b>#{this.series.name}</b><br/><b>#{this.x}: #{Highcharts.numberFormat(this.y, 0)} TWh/yr </b>"
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 65
          y: 0
      },
      yAxis: {
        labels:
          formatter: ->
            return this.value / 1000 + 'k'
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
        },
        min: 0,
        max: 1000,
        width: 225
      },
      xAxis: {width: 250},
      legend: {
        itemStyle: {fontSize: '7pt'}
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
                Highcharts.numberFormat(@yData[1], 0, ",")
                Highcharts.numberFormat(@yData[2], 0, ",")
                Highcharts.numberFormat(@yData[3], 0, ",")
                Highcharts.numberFormat(@yData[4], 0, ",")
                Highcharts.numberFormat(@yData[5], 0, ",")
                Highcharts.numberFormat(@yData[6], 0, ",")
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

    @supply_chart = new Highcharts.Chart({
      chart: {renderTo: 'supply_chart', height: 250, width: 295},
      title: {text: 'Electricity supply'},
      tooltip: {
        enabled: true,
        formatter: () ->
          "<b>#{this.series.name}</b><br/><b>#{this.x}: #{Highcharts.numberFormat(this.y, 0)} TWh/yr </b>"
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 65
          y: 0
      },
      yAxis: {
        labels:
          formatter: ->
            return this.value / 1000 + 'k'
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
        },
        min: 0,
        max: 1000,
        width: 225
      },
      xAxis: {width: 250},
      legend: {
        itemStyle: {fontSize: '7pt'}
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

    @electricity_overgeneration = new Highcharts.Chart({
      chart: {renderTo: 'electricity_overgeneration', height: 250, width: 295, type: 'line'},
      title: {text: 'Over-generation / Exports'},
      tooltip: {
        enabled: true,
        formatter: () ->
          "<b>#{this.series.name}</b><br/><b>#{this.x}: #{Highcharts.numberFormat(this.y, 0)} TWh/yr </b>"
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 65
          y: 0
      },
      yAxis: {
        labels:
          formatter: ->
            return this.value / 1 + ''
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
        },
        reversed: false,
        width: 225
      },
      xAxis: {width: 250},
      legend: {
        itemStyle: {fontSize: '7pt'}
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
              i = 0
              $("#display-data2 #SeriesName").html this.name
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



  teardown: () ->
    $('#results').empty()
    @demand_chart = null
    @supply_chart = null
    @electricity_overgeneration = null


  updateNavBar: () ->
    $('li.nav-item a.active').removeClass('active')
    $('li.nav-item:nth-child(2) a').addClass('active')


  updateResults: (@pathway) ->
    @updateNavBar()
    @setup() unless @demand_chart? && @supply_chart? && @electricity_overgeneration?


    # Demand for electricity
    titles = ['Transport', 'Industry', 'Cooking', 'Buildings', 'Pumps& Tractors']
    i = 0

    data = @pathway['electricity']['demand']['Total']
    if @demand_chart.series[i]?
      @demand_chart.series[i].setData(data, false)
    else
      @demand_chart.addSeries({
        type: 'line',
        name: 'Total demand',
        data: data,
        lineColor: '#000',
        color: '#000',
        lineWidth: 2,
        dashStyle: 'Dot',
        shadow: false
      }, false)
    i++

    for name in titles
      data = @pathway['electricity']['demand'][name]
      if @demand_chart.series[i]?
        @demand_chart.series[i].setData(data, false)
      else
        @demand_chart.addSeries({name: name, data: data}, false)
      i++


    titles = ["Gas Power Stations", "Coal power stations", "Carbon Capture Storage (CCS)",
      "Electricity Balancing Requirement", "Hydro and Nuclear",
      "Renewable Based Electricity", "Electricity imports"]

    titles_supply = ["Gas Power Stations", "Coal power stations", "CCS", "Electricity for Balancing",
      "Hydro and Nuclear", "Renewable", "Electricity imports"]

    i = 0

    data = @pathway['electricity']['supply']['Total generation supplied to grid']
    if @supply_chart.series[i]?
      @supply_chart.series[i].setData(data, false)
    else
      @supply_chart.addSeries({
        type: 'line',
        name: 'Total supply',
        data: data,
        lineColor: '#000',
        color: '#000',
        lineWidth: 2,
        dashStyle: 'Dot',
        shadow: false
      }, false)
    i++

    for name in titles
      data = @pathway['electricity']['supply'][name]
      if @supply_chart.series[i]?
        @supply_chart.series[i].setData(data, false)
      else
        @supply_chart.addSeries({name: titles_supply[i - 1], data: data}, false)
      i++


    # Supply of electricity
    electricity_titles = ["Overgeneration"]
    #exports = []
    i = 0
    for name in electricity_titles
      data = (@pathway['electricity']['overgeneration'][name])

      #Convert to positive
      data = data.map((x) ->
        Math.abs x
      )

      if @electricity_overgeneration.series[i]?
        @electricity_overgeneration.series[i].setData(data, false)
      else
        @electricity_overgeneration.addSeries({name: name, data: data}, false)
      i++

    # **************** Start Custom Legand *****************     
    ChartArr = [
      @demand_chart.series
      @supply_chart.series
      @electricity_overgeneration.series
    ]
    optionsArr = [
      @demand_chart.options.legend
      @supply_chart.options.legend
      @electricity_overgeneration.options.legend
    ]
    chartIdArr = [
      "#demand_chart"
      "#supply_chart"
      "#electricity_overgeneration"
    ]

    # calling common layout of legand

    twentyfifty.callCommon chartIdArr

    #$("#custom-legend1").css({ width: "170px"})


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


    $("#" + charts_id[0]).mouseover ->
      $("#custom-legend0").css visibility: "visible"
      $("#custom-legend0").css opacity: "0.9"
    $("#" + charts_id[0]).mouseout ->
      $("#custom-legend0").css visibility: "hidden"
      $("#custom-legend0").css opacity: 0

    $("#" + charts_id[1]).mouseover ->
      $("#custom-legend1").css visibility: "visible"
      $("#custom-legend1").css opacity: "0.9"
    $("#" + charts_id[1]).mouseout ->
      $("#custom-legend1").css visibility: "hidden"
      $("#custom-legend1").css opacity: 0

    $("#" + charts_id[2]).mouseover ->
      $("#custom-legend2").css visibility: "visible"
      $("#custom-legend2").css opacity: "0.9"
    $("#" + charts_id[2]).mouseout ->
      $("#custom-legend2").css visibility: "hidden"
      $("#custom-legend2").css opacity: 0

    # **************** End Custom Legand ***************** 

    @demand_chart.redraw()
    @supply_chart.redraw()
    @electricity_overgeneration.redraw()

    document.getElementById("warning").innerHTML = "<p>This scenario is over generating <b>" + @pathway['electricity']['overgeneration']['Overgeneration'][7] + " TWh </b> of electricity in 2050. You may want to dial back your supply options for minimizing this value</p>"

window.twentyfifty.views['electricity'] = new Electricity
