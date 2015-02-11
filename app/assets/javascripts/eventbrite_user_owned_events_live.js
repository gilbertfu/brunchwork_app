$(document).ready(function() {
  //url making request to
  var eventbriteAPI = "https://www.eventbriteapi.com/v3/users/me/owned_events/?token=TFRPXVUYU6YDUM2FL3VY";
  //optional, data query string to send additional info
  var query = {
    status:'live',
    order_by:'start_desc'
  };
  function displayEvents(data) {
    var eventHTML = '<h1>Upcoming Events</h1>';
    $.each(data.events, function (i, event) {
      eventHTML += '<div class="row">';
      eventHTML += '<div class="[ col-xs-12 col-sm-offset-2 col-sm-8 ]">';
      eventHTML += '<ul class="event-list">';
      eventHTML += '<li>';
      var dateArray = event.start.local.split('-');
      var year = parseInt(dateArray[0]);
      var month= parseInt(dateArray[1]);
      var dateTimeArray = dateArray[2].split('T');
      var date = parseInt(dateTimeArray[0]);
      var time = dateTimeArray[1];
      var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

      eventHTML += '<time datetime=' + year + '-' + month + '-' + date + '>';
      eventHTML += '<span class="day">' + date + '</span>';
      eventHTML += '<span class="month">' +monthNames[month-1] + '</span>';
      eventHTML += '<span class="year">' + year + '</span>';
      eventHTML += '<span class="time">' + time + '</span>';
      eventHTML += '</time>';
      
      if (event.logo_url) {
        eventHTML += '<img src="' + event.logo_url + '" height="150" width="150">';
      }
      
      eventHTML += '<div class="info">';
      eventHTML += '<h2 class="title">' +'<a href="' + event.url + '">' + event.name.text + '</a>' + '</h2>';
      eventHTML += '<ul>';
      eventHTML += '<li style="width:50%;"><span class="fa fa-globe"></span>';
      eventHTML += event.venue.address.address_1 + ' ';
      eventHTML += event.venue.address.city + ', ';
      eventHTML += event.venue.address.region + ' ';
      eventHTML += '</li>';
      
      
      var sold = 0;
      var total = 0;
      var soldOut = true;
      for (i = 0; i < event.ticket_classes.length; i++ ) {
        sold = event.ticket_classes[i].quantity_sold;
        total = event.ticket_classes[i].quantity_total;
        if (sold < total) {
          soldOut = false;
        }
      }
      if (!soldOut) {
        eventHTML += '<li style="width:50%;"> <a href="' + event.url + '">Buy tickets!</a> </li>'
      } else {
         eventHTML += '<li style="width:50%;"> Sold out! </li>'
      }
      eventHTML += '<ul></div></li></ul></div></div>';
    });
    $('#poop').html(eventHTML);
  }
  $.getJSON(eventbriteAPI, query, displayEvents);
  
  function displayPastEvents(data) {
    var eventHTML = '<h1>Past Events</h1>';
    $.each(data.events, function (i, event) {
      eventHTML += '<div class="row">';
      eventHTML += '<div class="[ col-xs-12 col-sm-offset-2 col-sm-8 ]">';
      eventHTML += '<ul class="event-list">';
      eventHTML += '<li>';
      var dateArray = event.start.local.split('-');
      var year = parseInt(dateArray[0]);
      var month= parseInt(dateArray[1]);
      var dateTimeArray = dateArray[2].split('T');
      var date = parseInt(dateTimeArray[0]);
      var time = dateTimeArray[1];
      var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

      eventHTML += '<pasttime datetime=' + year + '-' + month + '-' + date + '>';
      eventHTML += '<span class="day">' + date + '</span>';
      eventHTML += '<span class="month">' +monthNames[month-1] + '</span>';
      eventHTML += '<span class="year">' + year + '</span>';
      eventHTML += '<span class="time">' + time + '</span>';
      eventHTML += '</pasttime>';
      
      if (event.logo_url) {
        eventHTML += '<img src="' + event.logo_url + '" height="150" width="150">';
      }
      
      eventHTML += '<div class="info">';
      eventHTML += '<h2 class="title">' +'<a href="' + event.url + '">' + event.name.text + '</a>' + '</h2>';
      eventHTML += '<ul>';
      eventHTML += '<li style="width:50%;"><span class="fa fa-globe"></span>';
      eventHTML += event.venue.address.address_1 + ' ';
      eventHTML += event.venue.address.city + ', ';
      eventHTML += event.venue.address.region + ' ';
      eventHTML += '</li>';
      
      
      var sold = 0;
      var total = 0;
      var soldOut = true;
      eventHTML += '<li style="width:50%;"> Event has ended </li>'
      eventHTML += '<ul></div></li></ul></div></div>';
    });
    $('#crap').html(eventHTML);
  }
  /* why is this here */
 // $.getJSON(eventbriteAPI, query, displayEvents);
  
  $('button').click(function() {
    $('button').removeClass("selected");
    $(this).addClass("selected");
    
    var query2 = {
      status:'ended',
      order_by:'start_desc'
    };
    $.getJSON(eventbriteAPI, query2, displayPastEvents);
  });
});
