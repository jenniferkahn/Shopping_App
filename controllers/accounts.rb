class AccountController < ApplicationController

   # registration for user
   get '/register' do
      erb :register
   end

   post '/register' do
      p params
      # calls method with arg of username from register form

      if does_user_exist(params[:user_name]) == true
         return { :message => 'womp, womp... user exists'}.to_json
      end

      user = Account.create(user_name: params[:user_name], user_email: params[:user_email], password: params[:password])
      p user
      # a login sets a session going ("session is a hash")
      session[:current_user] = user  # user
      redirect '/'
   end

   get '/' do
      authorization_check
      @user_name = session[:current_user].user_name
      @items = Item.all
      erb :read
   end

   get '/authorization_check' do
      erb :not_authorized
   end

   # login
   get '/login' do
      erb :login
   end

   post '/login' do

      user = Account.authenticate(params[:user_name], params[:password])
      if user # if user (not nil) returned by authenticate method
         session[:current_user] = user
         redirect '/'
      else
         @message = 'Sorry. Email or password not found. Please Try again.'
         erb :login
      end
   end


   get '/logout' do
      authorization_check
      session[:current_user] = nil # end session
      redirect '/'
   end

end # end of class
