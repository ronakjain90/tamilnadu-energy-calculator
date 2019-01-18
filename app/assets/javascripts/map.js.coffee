LandShare = "
  <div id='PercentLand' style='float:right; width:100%'>
    <h6>Percent Share of Land Requirement (2050)</h6>
    <table style='width:100%; float:left' cellpadding='8' border=1>
    </table>
  </div>
"

class LandUse

  constructor: () ->

  html = ""

  setup: () ->
    document.getElementById("results").style.width = "100%"
    target = $('#results')

    target.append("<div id='land_use' class='chart'></div>")
    target.append("<div id='land_map' style='background-image:url(../../assets/images/tamil03.svg.png);background-size: 100% 100%; background-repeat: no-repeat;' class='chart'></div>")
    target.append("<div id='land_share' class='chart'></div>")

    target.append(html)

    document.getElementById("pathway_box").style.display = "block"
    document.getElementById("classic_controls").style.display = "block"
    document.getElementById("land_use").style.width = "50%"
    document.getElementById("land_map").style.width = "25%"
    document.getElementById("land_map").style.height = "300px"
    document.getElementById("land_share").style.width = "25%"
    document.getElementById("warning").style.display = "none"
    $('#land_share').append(LandShare)
    $('#warning').empty()

    document.getElementById("results").style.overflow = "inherit"
    document.getElementById("display_table").style.display = "none"
    document.getElementById("print_div").style.display = "none"

    @land_chart = new Highcharts.Chart({
      chart: {
        renderTo: 'land_use',
        type: 'bar', height: 250,
        margin: [55, 25, 15, 90],
      },
      title: {text: 'Land Footprint (2050)'},
      subtitle: {text: "In Million hectares of land"},
      yAxis: {
        labels:
          formatter: ->
            return Math.round(this.value / 1) + ''
        title: null
      },

      xAxis: {
        categories: ['Renewables Energy',
          'Conventional Energy',
          'Bioenergy', 'Total'],
        labels:
          formatter: ->
            @value
      },

      legend: {
        enabled: true,
        backgroundColor: 'rgba(0,0,0,0.1)',
        floating: true,
        align: 'center',
        verticalAlign: 'middle',
        itemStyle: {
          font: '8pt sans-serif',
        },
      },

      tooltip: {
        formatter: () ->
          "<b>#{this.series.name}</b><br/>#{this.x}: #{Highcharts.numberFormat(this.y, 1)} M ha"
      },

      plotOptions: {
        series: {
          dataLabels: {
            enabled: true,
            color: 'black',
            formatter: () ->
              " #{Highcharts.numberFormat(this.y, 1)}"
          }
        }
      },

      series: []

    })


    @land_map = new Highcharts.Chart({
      chart: {
        renderTo: 'land_map',
        type: 'pie', height: 250, width: 300,
        backgroundColor: 'Transparent',
        margin: [0, 0, 0, 0],
        spacingTop: 0,
        spacingBottom: 0,
        spacingLeft: 0,
        spacingRight: 0
      },
      title: {text: ''},

      legend: {
        enabled: false
      },

      tooltip: {
        enabled: true,
        shared: true
        style:
          fontSize: "9px"
          padding: "8px"
        positioner: ->
          x: 10
          y: 10

        pointFormat: '<b>{point.y:.1f} M ha</b>',

      },
      plotOptions: {
        pie: {
          size: '35%',
          center: [90, 105],
          allowPointSelect: true,
          cursor: 'pointer'
        }
      },
      series: []
    })

  teardown: () ->
    document.getElementById("results").style.width = "100%"
    document.getElementById("results").style.marginRight = "0"
    document.getElementById("results").style.overflow = "hidden"
    $('#results').empty()
    $('#land_share').empty()

    @land_chart = null
    @land_map = null

  updateNavBar: () ->
    $('li.nav-item a.active').removeClass('active')
    $('li.nav-item:nth-child(5) a').addClass('active')

  updateResults: (@pathway) ->
    @updateNavBar()
    @setup() unless @land_chart? && @land_map?

    $('#results p b').html((@pathway['land_do_nothing']["State's Land Area"][1]).toFixed(0) + ' M ha')

    titles_land_do_nothing = ['Renewables', 'Conventional', 'Bio Energy', 'Total']

    scenarios = ["Determined Effort", "Your Pathway"]

    i = 0
    #Store values for the textbox, also convert to 1000km2
    dnsum = 0.0
    ypsum = 0.0

    lfs = []
    yourpath = []

    for name in titles_land_do_nothing
      data = @pathway['land_do_nothing'][name]
      dnsum += data[0]
      ypsum += data[1]

      lfs.push parseFloat (data[0]).toFixed(2)
      yourpath.push parseFloat (data[1]).toFixed(2)

    if @land_chart.series[0]?
      @land_chart.series[0].setData(lfs)
      @land_chart.series[1].setData(yourpath)
    else
      @land_chart.addSeries
        name: scenarios[0]
        data: lfs
      , false

      @land_chart.addSeries
        name: scenarios[1]
        data: yourpath
      , false


    #remaining = @pathway['land_do_nothing']["India's Land Area"][1] - @pathway['land_do_nothing']["Total"][1]

    data = [{name: "Bio Energy", y: @pathway['land_do_nothing']["Bio Energy"][1]},
      {name: "Conventional", y: @pathway['land_do_nothing']["Conventional"][1]},
      {name: "Renewables", y: @pathway['land_do_nothing']["Renewables"][1]}]
    if @land_map.series[0]?
      @land_map.series[0].setData(data, false)
    else
      @land_map.addSeries({name: 'Total Area', colorByPoint: true, data: data}, false)

    data = [((@pathway["land_do_nothing"]["Renewables"][1]) / (@pathway["land_do_nothing"]["State's Land Area"][1]) * 100).toFixed(2),
      ((@pathway["land_do_nothing"]["Conventional"][1]) / (@pathway["land_do_nothing"]["State's Land Area"][1]) * 100).toFixed(2),
      ((@pathway["land_do_nothing"]["Bio Energy"][1]) / (@pathway["land_do_nothing"]["State's Land Area"][1]) * 100).toFixed(2),
      ((@pathway["land_do_nothing"]["Total"][1]) / (@pathway["land_do_nothing"]["State's Land Area"][1]) * 100).toFixed(2)]


    $('#PercentLand table').empty()
    $('#PercentLand table').append('<tr><td>Renewables</td><td>' + data[0] + '%</td></tr><tr><td>Conventional</td><td>' + data[1] + '%</td></tr><tr><td>Bio Energy</td><td>' + data[2] + '%</td></tr><tr><td>Total</td><td>' + data[3] + '%</td></tr>')

    @land_chart.redraw()
    @land_map.redraw()

window.twentyfifty.views['map'] = new LandUse
