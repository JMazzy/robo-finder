#!/usr/bin/env ruby

require 'sinatra'
require 'thin'
require 'sinatra/reloader' if development?
require 'pry-byebug' if development?

enable :sessions

get '/' do
  erb :index
end
