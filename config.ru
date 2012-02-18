require "./app"

ROOT_PATH = File.expand_path(File.dirname(__FILE__))

use Rack::Static, :urls => ["/viewmodels", "/libs", "/favicon.ico", "/style.css"], :root => File.join(ROOT_PATH, 'public')




run Cuba