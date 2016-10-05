require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pry'

# Load the file to connect to the DB
require_relative 'db/connection'

# Load models
require_relative 'models/pokemon'
require_relative 'models/team'
require_relative 'models/trainer'

get '/pokemon' do
  @pokemon = Pokemon.all
  erb :"pokemon/index"
end

get '/pokemon/new' do
  erb :"pokemon/new"
end

post '/pokemon' do
  @pokemon = Pokemon.create(params[:pokemon])
  redirect "/pokemon/#{@pokemon.id}"
end

get "/pokemon/:id/edit" do
  @pokemon = Pokemon.find(params[:id])
  erb(:"pokemon/edit")
end

put '/pokemon/:id' do
  @pokemon = Pokemon.find(params[:id])
  @pokemon.update(params[:pokemon])
  redirect ("/pokemon/#{@pokemon.id}")
end

get '/pokemon/:id' do
  @pokemon = Pokemon.find(params[:id])
  erb :"pokemon/show"
end

delete "/pokemon/:id" do
  @pokemon = Pokemon.find(params[:id])
  @pokemon.destroy
  redirect("/pokemon")
end

get '/team' do
  @team = Team.all
  erb :"team/index"
end

get '/team/:name' do
  @team = Team.find_by(name: params[:name].capitalize)
  erb :"team/show"
end
