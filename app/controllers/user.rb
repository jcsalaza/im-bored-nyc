get '/user/new' do 
  erb :signup
end

post '/user/new' do 
  this_user=User.create(params[:new_user]) if params[:new_user][:password] == params[:password_confirmation]
  session[:current_user]=this_user.id
  redirect "/user/#{this_user.id}"
end

get '/user/:id/events' do 
  this_user=User.find(params[:id])
  @users_events=this_user.events
  erb :my_events
end

post '/user/:id/events' do 

end

get '/user/:id' do 
  @user=User.find(params[:id])

  erb :profile
end

post '/user/:id' do 
  # ------API call using form params ---- 
  address=params[:address].strip
  address=address.gsub(" ", "+")

  google_api_front_url = "http://maps.googleapis.com/maps/api/geocode/json?address="
  google_api_back_url = "&sensor=false"
  map_request = google_api_front_url + address + google_api_back_url

  map_json_reply = JSON.load( RestClient.get( map_request ) )
  lat = map_json_reply["results"][0]["geometry"]["location"]["lat"]
  lng = map_json_reply["results"][0]["geometry"]["location"]["lng"]

  latlng = "#{lat},#{lng}"
  nyt_request = "http://api.nytimes.com/svc/events/v2/listings.json?ll=#{latlng}&radius=8000&sort=dist+asc&api-key=#{ENV["NY_TIMES_KEY"]}"
  events_json_reply = JSON.load( RestClient.get( nyt_request ) )

  events = events_json_response["results"].each_with_object [] do |result, events|
    event = {}

    event[:name] = result["event_name"]
    event[:location] = "#{result["venue_name"]} in #{result["neighborhood"]}, #{result["street_address"]} #{result["cross_street"]}"
    event[:description] = result["web_description"] #remember!!! this has <p> tags

    events << event
  end

  @search_events = []

  events.each do |event|
    Event.find_or_create_by(name: event[:name], location: event[:location], description: event[:description])
    @search_events << event.to_json  
  end

  @search_events
end



