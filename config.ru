$LOAD_PATH << './lib'
require 'api_server'

use Rack::Reloader, 0

run ApiServer.new