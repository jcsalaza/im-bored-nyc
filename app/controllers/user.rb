require 'rest_client'
require 'json'

get '/user/new' do 
  erb :signup
end

post '/user/new' do 
  this_user=User.create(params[:new_user]) if params[:new_user][:password] == params[:password_confirmation]
  session[:current_user]=this_user.id
  redirect "/user/#{this_user.id}"
end

# ---- DON'T FORGET --- ADD 'if sessions...' later to check if logged in

get '/user/:id/events' do 
  @user=User.find(params[:id])
  @users_events=@user.events
  erb :my_events
end

delete '/user/:id/events' do 
  @user=User.find(params[:id])
#  ????
  attending_event = UserEvent.find_by(user_id: @user.id, event_id:@user.events.first ) #totally not right, just something to be a placeholder for now, come back to it
  attending_event.destroy # ... if trash icon clicked
end

get '/user/:id' do 
  @user=User.find(params[:id])

  erb :profile
end

post '/user/:id' do 
  # ------API call using form params -------
  address=params[:address].strip
  address=address.gsub(" ", "+")

  google_api_front_url = "http://maps.googleapis.com/maps/api/geocode/json?address="
  google_api_back_url = "&sensor=false"
  map_request = google_api_front_url + address + google_api_back_url

  map_json_reply = JSON.load( RestClient.get( map_request ) )
  lat = map_json_reply["results"][0]["geometry"]["location"]["lat"]
  lng = map_json_reply["results"][0]["geometry"]["location"]["lng"]

  latlng = "#{lat},#{lng}"
  nyt_api_key = "#{ENV['NY_TIMES_KEY']}" # works with the actual API key here but not with the env
  nyt_api_request = "http://api.nytimes.com/svc/events/v2/listings.json?ll=#{latlng}&radius=8000&sort=dist+asc&api-key=#{nyt_api_key}"
  events_json_response = JSON.load( RestClient.get( nyt_api_request ) )

  events = events_json_response["results"].each_with_object [] do |result, events|
    event = {}

    event[:name] = result["event_name"]
    event[:location] = "#{result["venue_name"]} in #{result["neighborhood"]}, #{result["street_address"]} #{result["cross_street"]}"
    event[:description] = result["web_description"] #remember!!! this has <p> tags
    event[:time] = result["date_time_description"]

    events << event
  end

  @search_events = []
  @search_events_2 = []
  events.each do |event|
    @search_events << Event.find_or_create_by(name: event[:name], location: event[:location], description: event[:description], time: event[:time]) 
    @search_events_2 << event
  end
#  ---------------------------------
  # js_events = @search_events_2.to_json
  # js_events
end


