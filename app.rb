#!/usr/bin/env ruby

require 'sinatra'
require 'thin'
require 'sinatra/reloader' if development?
require 'pry-byebug' if development?
require 'httparty'
require 'figaro'
require './helpers/search_helper.rb'
require 'pp'

enable :sessions

helpers SearchHelper

get '/' do
  erb :index
end

get '/assessment' do
  erb :assessment
end

get '/results' do
  search_string = build_search_string

  results = search(search_string)

  erb :results, locals: { results: results }
end

get '/about' do
  erb :about
end
