get '/' do 

  erb :index
end

post '/' do 
  user_logging_in=User.find_by(params[:email])
  if user_logging_in.authenticate(params[:password])
    session[:current_user]=user_logging_in.id
    redirect "/user/#{user_logging_in.id}"
  end
end

