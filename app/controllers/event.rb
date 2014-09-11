get '/event/:id' do 
  @event = Event.find(params[:id])
  @user = User.find(session[:current_user])

  erb :show_event
end

post '/event/:id' do
  this_event = Event.find(params[:id])
  current_user = User.find(session[:current_user])
  current_user.events << this_event
end