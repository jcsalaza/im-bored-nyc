get '/' do 

  erb :index
end

post '/' do 
  user_logging_in=User.find_by(email: params[:email])
  if user_logging_in.authenticate(params[:password])
    session[:current_user]=user_logging_in.id
    redirect "/user/#{session[:current_user]}"
  end
end

get '/logout' do 
  session.clear
  redirect '/'
end