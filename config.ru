# require sinatra/base which gives via inheritance to controller classes
# require controllers and model(s)

require 'sinatra/base'


# require controllers and models
require('./controllers/application')
require('./controllers/items')
require('./controllers/accounts')
require('./models/item') # to map to db table items
require('./models/account') # models/account.rb
# require './app' not needed


## map resource to a controller
map('/') { run ApplicationController}
map('/item') { run ItemController }
map('/') { run AccountController }

# mapping the root =  '/'
