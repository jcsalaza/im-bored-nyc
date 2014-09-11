get '/event/:id' do 
  erb :show_event
end

post '/event/:id' do
  @event = Event.find(params[:id])
end

put '/event/:id' do # this is where the user would disassociate the event from their list. maybe delete...or maybe just don't display the add button if it's in the list
  @event = Event.find(params[:id])

end