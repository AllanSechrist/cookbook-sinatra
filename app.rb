require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require_relative "repository/cookbook"

csv_file = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file)

get "/" do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  data = {
    name: params[:name],
    description: params[:description],
    rating: params[:rating],
    prep_time: params[:preptime]
  }
  cookbook.create(data)
  redirect "/"
end

get "/about" do
  erb :about
end

get "/team/:username" do
  # binding.pry
  puts params[:username]
  "The username is #{params[:username]}"
end
