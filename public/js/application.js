var searchListView = function(object) {
  return ("<div id='event_search_item'><li><h3 id ='event_name'>"+object['name']+"</h3><br>"+object['description']+"</li><a href='/event/"+object['id']+"'><button id='view_event_button' class='btn btn-default btn-lg'><span class='glyphicon glyphicon-plus'></span>View/Add Event</button></a></div>") ;
}

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

  $('#user_search_bar').on('submit', function(event) {
    event.preventDefault();
  
    $.ajax({
      type: 'POST',
      url: '/user/' + pathArray[pathArray.length - 1],
      data: $(this).serialize(),
      dataType: 'json',
      success: function (result) {
        console.log(result);
        result.forEach( function (object) {
          $('#event_search_list').append(searchListView(object));
        })
        $('#event_search_list').show();
      },
      error: function(error) {
        console.log(error);
        $('event_search_list').html('Whoops! No results for that area.');
      } 
    })
  })
    
// still need to add ajax for displaying the list of events

});
