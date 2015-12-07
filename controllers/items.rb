class ItemController < ApplicationController

   # display shopping list
   get '/' do
      @items = Item.all
      # get all items in table and set to variable
      # now return a views
      erb :read
   end

   # create new items for list
   get '/create' do
      erb :create # create view with form
   end

   post '/create' do

      # creates a "new intance of the Item model" then save
      p params
      @item = Item.new
      @item.name = params[:name]
      @item.quantity = params[:quantity]
      @item.save
      # return view
      @message = 'Added to the list!'
      erb :message
   end

   # view to update a list item
   get '/update/:id' do
      # we find using hidden input on the view form
      @item = Item.find( params[:id] )
      # return view
      erb :update
   end

   post '/update' do
      # similar to create but we find & modify existing
      # vs. creating a new one
      # we find using hidden input on the view form
      p params
      @item = Item.find( params[:id] )
      @item.name = params[:name]
      @item.quantity = params[:quantity]
      @item.save
      # return view
      @message = 'Item updated!'
      erb :message # displays contents of @message variable
   end

   # view to destroy a list item
   get '/destroy/:id' do
      p params
      @item = Item.find( params[:id] )
      erb :destroy
   end

   post '/destroy' do
      p params
      @item = Item.find( params[:id] )
      @item.destroy
      # return view
      @message = 'Item removed from list!'
      erb :message
   end

end 
