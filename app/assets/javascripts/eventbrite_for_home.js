$(document).ready(function() {
  //url making request to
  var eventbriteAPI = "https://www.eventbriteapi.com/v3/users/me/owned_events/?token=TFRPXVUYU6YDUM2FL3VY";
  //optional, data query string to send additional info
  var query = {
    status:'live'
  };
  function displayEventsHome(data) {
    var eventHTML = ' ';
    $.each(data.events, function (i, event) {
      eventHTML += '<li>';
      eventHTML += '<div class="flex-twitter-icon"></div>';
      eventHTML += '<h2 class="twitter-post-username">';
      var dateArray = event.start.local.split('-');
      var year = parseInt(dateArray[0]);
      var month= parseInt(dateArray[1]);
      var dateTimeArray = dateArray[2].split('T');
      var date = parseInt(dateTimeArray[0]);
      var time = dateTimeArray[1];
      var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

      //eventHTML += '<a href="' + event.url + '">' + monthNames[month-1] + " " + date + ", " + year + '</a>';
      eventHTML += "Speaker" + i;

      eventHTML += '</h2>';
      //eventHTML += '<p>' +event.venue.address.address_1 + ' ';
      //eventHTML += event.venue.address.city + ', ';
      //eventHTML += event.venue.address.region + '</p>' ;
      //eventHTML += '<p class="twitter-post">'+ event.name.text ;
      eventHTML += '<p class="twitter-post"> small blurb about speaker';
      if (event.logo_url) {
        eventHTML += '<img src="' + event.logo_url + '" height="150" width="150">';
      }
      
      eventHTML += '</p>' + '</li>';
      //eventHTML += '</li>';
      
      
    });
    $('#rotating_event').html(eventHTML);
      $('.flexslider').flexslider({
    //animation: "slide",
    directionNav: false,
    controlNav: true,
    });
  }
  $.getJSON(eventbriteAPI, query, displayEventsHome);
});

/*
<li>
									<div class="flex-twitter-icon"></div>
									<h2 class="twitter-post-username">
									<a href="#">AOS New York @aod</a> <span>/ 35 min</span>
									</h2>
									<p class="twitter-post">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut tellus ac nulla semper rhoncus. Nullam a odio porttitor, dictum turpis vitae, pretium ante amet.</p>
								</li>*/