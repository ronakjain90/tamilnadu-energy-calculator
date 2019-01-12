// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//

// First the support libs
//= require jquery/dist/jquery.js
//= require jquery.jsonplugin.min
//= require bootstrap
//= require bootstrap-tour/build/js/bootstrap-tour-standalone.js
//= require tour

//= require highcharts
//= require highcharts-more
//= require highcharts.setOptions
//= require highslide-full
//= require jquery.tools.min
//= require customEvents
//= require shims
//= require d3.min
//= require raphael/raphael-min.js
//= require jstorage.min
//= require sankey

// Now the common methods
//= require model_structure
//= require pathways
//= require costs_common_methods
//= require common_legends


// Now the individual views
//= require primary_energy
//= require primary_energy_overview
//= require primary_energy_detail
//= require electricity
//= require electricity_analysis
//= require energy_security
//= require map
//= require sankey_display

//= require grid_balancing_summer
//= require grid_balancing_monsoon
//= require grid_balancing_winter
//= require total_cost
//= require costs
//= require costsYear


//= require my_story
//= require assumptions
// require simple_sankey

//= require emmissions



$(document).ready(function(){

    var arr = {'primary_energy_chart': 'All Energy','primary_energy_detail_chart': 'All Energy','primary_energy_overview_chart': 'All Energy', 'primary_energy_overview_chart': 'All Energy','electricity': 'Electricity','energy_security': 'Energy Security', 'emissions': 'Energy Emissions', 'sankey': 'Energy Flow','map': 'Land Requirement','grid_balancing_summer': 'Grid Balancing', 'grid_balancing_monsoon': 'Grid Balancing', 'grid_balancing_winter': 'Grid Balancing', 'total_cost': 'Energy Costs', 'costs': 'Energy Costs', 'costsYear': 'Energy Costs', 'my_story': 'My Story', 'assumptions': 'Assumptions'};

    var tabHeading= window.location.pathname.split("/").slice(3, 4);
    $(".breadcrumb li:first").html(arr[tabHeading]);

    var $targetElement = $("ul.navbar-nav a.nav-link");
    $targetElement.click(function() {
       var tabHeading= window.location.pathname.split("/").slice(3, 4);
       var pathText = $("#pathway_box select option:selected").text();
       $(".breadcrumb li:first").html(arr[tabHeading]);
    });

    $('#pathway_box select').on("change",function() {

      var str = "";
      $( "#pathway_box select option:selected" ).each(function() {
        str =  $( this ).text();
      });
      $(".breadcrumb li:last").html(str);
    });

});

    var detailGroupVisible = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

function switchOpenCloseIcon (id) {

  if (id == 0) return;


    detailGroupVisible[id-1] = !detailGroupVisible[id-1];

    if (detailGroupVisible[id-1]) {
      document.getElementById("m-" + id).src="/assets/images/close.png"; }
    else                          
      document.getElementById("m-" + id).src="/assets/images/open.png";
  
  
}

function CallPrint() {
    //alert('ok');
    var prtContent = document.getElementById('Mystory');
    var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
    WinPrint.document.write(prtContent.innerHTML);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();
    //prtContent.innerHTML = strOldOne;
}


function sitevisit() {
  if (! confirm('You are going to visit external Website, Are you sure to continue?'))
    return false;
}

function tweetCurrentPage()
{
  window.open("https://twitter.com/share?url="+escape(window.location.href)+"&text="+document.title, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false;
}


function fbCurrentPage()
    //{ window.open("https://www.facebook.com/sharer/sharer.php?u=http://localhost:9292/pathways/22222222222222222222222222212222222222222211222222222222222/primary_energy_chart&text="+document.title, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false; }
    { window.location.href="https://facebook.com/sharer/sharer.php?u=localhost:9292/pathways/22222222222222222222222222212222222222222211222222222222222/primary_energy_chart&t="+document.title; }

