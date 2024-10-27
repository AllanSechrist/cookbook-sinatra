require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"

get "/" do
  @usernames = ["ssaunier", "Papillard"]
  erb :index
end

get "/about" do
  erb :about
end

get "/team/:username" do
  # binding.pry
  puts params[:username]
  "The username is #{params[:username]}"
end
