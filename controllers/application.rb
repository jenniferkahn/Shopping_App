class ApplicationController < Sinatra::Base

   require 'bundler'
   Bundler.require

   # run connection method of ActiveRecord
   ActiveRecord::Base.establish_connection(
      :database => 'shopping_list',
      :adapter => 'postgresql'
   )

   set :views, File.expand_path('../../views', __FILE__)
   set :public_dir, File.expand_path('../../public', __FILE__)

   # this will go in ApplicationController
   enable :sessions

   # helper method: called from post reg and post login
   # takes username arg and looks for it in Account (accounts table)
   def does_user_exist(username)
      # note :db_column_name syntax like "params[:id]"
      user = Account.find_by(:user_name => username)
      if user
         return true
      else
         return false
      end
   end

   # is session active for current_user = authorized to see this resource?
   # if not, redirect them and tell them so....
   def authorization_check
      # sessions take user info from db and hold it
      # during their session so not continually going to db
      # and so we know a current session exists for them
      if session[:current_user] == nil
         redirect '/not_authorized'
      else
         return true
      end
   end

   not_found do
      erb :not_found
   end

end # end ApplicationController
