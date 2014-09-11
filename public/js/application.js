$(document).ready(function() {
  var pathArray = window.location.pathname.split('/');
  if (pathArray[pathArray.length - 1] === 'logout') {
  $('li#logout').addClass("active"); 
  }
  else if (pathArray[pathArray.length - 1] === 'events') {
  $('li#myevents').addClass("active"); 
  }
  else {
  $('li#home').addClass("active");
  }


// still need to add ajax for displaying the list of events

});
