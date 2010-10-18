require 'rubygems'
require 'sinatra'
require 'color'

set :views, File.dirname(__FILE__) + '/views'

get "/color" do
  erb :colors
end

post "/color" do
  @color = Color.create :hex_value => params[:color], :width => params[:width], :height => params[:height]
  
  erb :colors
end

get "/color/new" do
  if params[:color] && params[:width] && params[:height]
  
    @color = Color.new :hex_value => params[:color], :width => params[:width], :height => params[:height]
  else
    @color = Color.new :hex_value => "00eeff", :width => 50, :height => 50
  end
  
  erb :preview
end