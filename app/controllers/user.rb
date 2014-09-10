get '/user/new' do 
  erb :signup
end

post '/user/new' do 
  this_user=User.create(params[:new_user]) if params[:new_user][:password] == params[:password_confirmation]
  session[:current_user]=this_user.id
  redirect "/user/#{this_user.id}"
end