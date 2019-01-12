headers = """
          <script type="text/javascript">var switchTo5x=true;</script>
          <script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
          <script type="text/javascript">stLight.options({publisher: "90b930ce-8b5b-4777-9571-dba374f079a7", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>
"""

shareHTML = """
 <div id='share'>
    <div id='url'>
      <h1>Sharing this scenario with others</h1>
      <p>
        To share this scenario, just send someone the url, or click this share button:

        <span class='st_sharethis_large' displayText='ShareThis'></span>
        <span class='st_facebook_large' displayText='Facebook'></span>
        <span class='st_twitter_large' displayText='Tweet'></span>
        <span class='st_linkedin_large' displayText='LinkedIn'></span>
        <span class='st_googleplus_large' displayText='Google +'></span>
        <span class='st_pinterest_large' displayText='Pinterest'></span>
        <span class='st_email_large' displayText='Email'></span>
        <!--span class='st_plusone_large' displayText='Google +1'></span>
        <span class='st_fblike_large' displayText='Facebook Like'></span-->

        <!-- AddThis Button BEGIN
        <a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;username=tomcounsell"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
        <script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
        <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=tomcounsell"></script>
        <!-- AddThis Button END-->
      </p>
      <!--p>* On modern browsers, this url is the same as the one you will see in the address bar as you use the TNSEC 2050 tool. On older browsers, such as Internet Explorer 6 and 7, it will not be.</p>
    </div>
    <div id='excel'>
      <h1>Sharing this scenario with the excel version of the Tamilnadu State Energy Calculator 2050</h1>
      <p>
        You may want to explore your scenario in more detail, taking a look at all the assumptions behind our modelling, by downloading
        <a href="http://planningcommission.nic.in/sectors/index.php?sectors=energy">the underlying excel spreadsheet.</a>
      </p>
      <p>
        If you do, then you can recreate the scenario you have chosen in this tool by copying the numbers from the box below and pasting them in cells E5 to E57 on the 'Control' sheet of the workbook. You can also copy a pathway from that range in the excel model, paste it in the box below and click the 'Go to this scenario' button at the bottom of the page.
        <form>
          <textarea></textarea>
          <input onclick="twentyfifty.loadFromExcel();" type="button" value="Go to this scenario" />
        </form>
      </p-->
    </div>
  </div>
"""

class Share

  constructor: () ->
    @ready = false
    switchTo5x = true
    $.getScript "http://w.sharethis.com/button/buttons.js", ->

    stLight = options: ->
      false
    stLight.options
      publisher: "90b930ce-8b5b-4777-9571-dba374f079a7"
      doNotHash: false
      doNotCopy: false
      hashAddressBar: false

  setup: () ->
    return false if @ready
    @ready = true
    $('#results').append(shareHTML)

#    $('#results').append(questions)
#
#    risposte = new Object()
#    $domande = $(".question")
#    $domande.hide()
#    totDomande = $(".question").size()
#    domandaOn = 0
#    risultato = ""
#    $($domande.get(domandaOn)).fadeIn()
#    console.log domandaOn
#    $(".option").click ->
#      risposta = ($(this).attr("value"))
#      domanda = ($(this).attr("name"))
#      risultato += risposta
#      $($domande.get(domandaOn)).fadeOut ->
#        domandaOn += 1
#        if domandaOn is totDomande
#          resFinale = ""
#          console.log "risultato into 6: " + risultato
#          console.log resFinale
#          alert "Result : " + risultato
#        else
#          $($domande.get(domandaOn)).fadeIn()

  teardown: () ->
    $('#results').empty()
    @ready = false
  
  updateResults: (@pathway) ->
    @setup() unless @ready
    url = "http://#{window.location.host}#{twentyfifty.url({action:'primary_energy_chart'})}"
    #$('#share input')[0].value = url
#    $('#share a#pathwayurl').text(url)
#    $('#share a#pathwayurl').attr({href:url})
#    $('#excel textarea').val(twentyfifty.getChoices().join(""))
#    $('#excel textarea').css('width', '500px')
#    $('#excel textarea').css('height', '15px')


loadFromExcel = () ->
  #pasted_choices = $('#excel textarea').val().split(/\r\n|\r|\n/)
  pasted_choices = $('#excel textarea').val().split('')
  #pasted_choices = for c in pasted_choices
  #  if c == ""
  #    "0"
  #  else
  #    c
  twentyfifty.setChoices(pasted_choices)
  twentyfifty.switchView('primary_energy_chart')
  return false

window.twentyfifty.loadFromExcel = loadFromExcel
window.twentyfifty.views['share'] = new Share
