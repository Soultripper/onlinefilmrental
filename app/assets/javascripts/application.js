// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var films
$(function()
{
  $('#tabs div').hide();
  $('#tabs div:first').show();
  $('#tabs ul li:first').addClass('active');
  $('#tabs ul li a').click(function(){ 
  $('#tabs ul li').removeClass('active');
  $(this).parent().addClass('active'); 
  var currentTab = $(this).attr('href'); 
  $('#tabs div').hide();
  $(currentTab).show();
  return false;
  });
})

function submitMe()
{
    myFilm = '[{"film":{"title":"Ice Age"}}, {"film":{"title":"Tope"}}]'
    $.ajax(
    {
      type: "POST",
      dataType:'json',
      contentType: "application/json",
      accepts: 'application/json',
      url: 'http://localhost:3002/film/create',
      data: JSON.stringify(films)
    })
}

function search()
{
  $("#content").html('')
  var search_term = encodeURI(encodeURI($('#search').val()))
 
  uri = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%20%3D%20'http%3A%2F%2Fwww.lovefilm.com%2Fbrowse%2Ffilm%2F%3Fquery%3D" + search_term + "%26rows%3D50'&diagnostics=true"
  //ri = "http://query.yahooapis.com/v1/yql?q=select%20*%20from%20html%20where%20url%20%3D%20'http%3A%2F%2Fwww.lovefilm.com%2Fbrowse%2Ffilm%2F%3Fquery%3D" + search_term + "'"
  //uri = "http://localhost:3002/lovefilm_weekly.xml"
  films = new Array()
  reference_ids = new Array()
  $.ajax(
  {
    dataType: "html",
    url: uri,
    error: function(xhr, status, error){alert(error)},
    success: function(data, status, xhr) 
    {
      
      $(".fl_detail", data).each(
        function(index, html)
        {
          var film = new Object()
          var film_div = $("<div class='film'></div>")
          film.reference_id =  $(".cover_link", html).attr('href').match(/.(\d+)\/$/)[1]
          if($.inArray(film.reference_id, reference_ids)>=0)
            return;

          reference_ids.push(film.reference_id)
          film.title = $(".cover_link img", html).attr('alt')         
          film.certification = $(".certif img", html).attr("alt")
          film.image_uri = $(".cover_link img", html).attr('src');
          //if(film.image_uri.indexOf("no_cover")<0)
          //  film.image_uri=  $(".cover_link img", html).attr('src').replace(/(\d*x\d*)/,'medium')
          if($(".release_decade", html).text())
            film.release_date = $(".release_decade", html).text().match(/.(\d*)./)[1]
          film.summary = $(".read_more p", html).text().trim()
          
          film.actors = $(".fl_detail_info div:nth-child(4)", html).text().replace(/Starring: /,'').trim()
          film.director = $(".fl_detail_info div:nth-child(5)", html).text().replace(/Director: /,'').trim()
          
          var img_tag = $("<img src='" + film.image_uri + "'>")
          $("#content").append(film_div.append(img_tag))

          //img_tag.mouseenter(function(){$(".details", film_div).removeClass('hidden')})
          //img_tag.mouseleave(function(){$(".details", film_div).addClass('hidden')})

          details = $("<div class='details hidden'></div>")


          details.append(($("<div class='title'/>").html(film.title)))
          details.append(($("<div class='year'/>").html(film.release_date)))
          details.append(($("<div class='certification'/>").html(film.certification)))
          details.append(($("<div class='summary'/>").html(film.summary.trim())))
          details.append(($("<div class='director'/>").html(film.director)))
          details.append(($("<div class='actors'/>").html(film.actors)))

          $("#content").append(film_div.append(details))
         
          films.push(film)
        })

      submitMe();
    }
  })
}