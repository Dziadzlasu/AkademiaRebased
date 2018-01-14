require 'bundler'
require 'digest'
require 'erb'
require 'fast_secure_compare/fast_secure_compare'

Bundler.require(:default)

require 'sinatra/reloader'
enable :sessions
set :sessions, :expire_after => 2592000
set :session_store, Rack::Session::Pool

def logged_in?
    !session[:id].nil?
end

get '/' do
  if logged_in?
      redirect '/logged'
  else
      erb :home
  end
end

post '/login' do
  password = params['password']
  stored_pw = File.read("password.txt")
  salt, stored_hash, timestamp = stored_pw.split(':')
  new_hash = Digest::SHA512.hexdigest salt+'#'+password+'#'+timestamp
  if FastSecureCompare.compare(new_hash, stored_hash)
    session[:id] = 'logged_in'
    redirect '/logged'
  else
    "Wrong password, please <a href='/'>try again</a>."
  end
end

get '/logged' do
  erb :logged
end

get '/logout' do
  session.clear
  redirect '/'
end
