get '/event/:id' do 
  @event = Event.find(params[:id])
  @user = User.find(session[:current_user])
  if @user.events.find(@event.id)
    @user_has_event = true
  else
    @user_has_event = false
  end

  erb :show_event
end

post '/event/:id' do
  this_event = Event.find(params[:id])
  current_user = User.find(session[:current_user])
  current_user.events << this_event
  redirect "/user/#{current_user.id}/events"
end