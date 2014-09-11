get '/event/:id' do 
  if session[:current_user]
    @event = Event.find(params[:id])
    @user = User.find(session[:current_user])
    if @user.events.include?(@event)
      @user_has_event = true
    else
      @user_has_event = false
    end

    erb :show_event
  else 
    redirect '/'
  end
end

post '/event/:id' do
  this_event = Event.find(params[:id])
  current_user = User.find(session[:current_user])
  current_user.events << this_event
  current_user.save
  redirect "/user/#{current_user.id}/events"
end

delete '/event/:id' do 
  current_user = User.find(session[:current_user])
  user_event_to_disassociate_by_delete = UserEvent.find_by(event_id: params[:id])
  user_event_to_disassociate_by_delete.destroy
  redirect "/user/#{current_user.id}/events"
end