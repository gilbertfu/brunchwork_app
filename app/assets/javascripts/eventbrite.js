/*$(document).ready(function() {
  var eventbriteAPI = "https://www.eventbriteapi.com/v3/users/me/owned_events/?status=all&token=";
  var query = {
  };
  function displayLogos(data) {
    var photoHTML = '<ul>';
    $.each(data.events, function (i, photo) {
      if (photo.logo_url) {
        photoHTML += '<li class="grid-25 tablet-grid-50">';
        photoHTML += '<img src="' + photo.logo_url + '"></a></li>'
      }
    });
    photoHTML += '</ul>';
    $('#photos').html(photoHTML);
  }
  $.getJSON(eventbriteAPI, query, displayLogos);
});
*/