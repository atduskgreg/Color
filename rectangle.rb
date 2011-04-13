# load up the ruby libraries
require 'rubygems'
require 'sinatra'
require 'dm-core'


# configure your app to store data as yaml files in db/
DataMapper.setup(:default, ENV['DATABASE_URL'] {:adapter => 'yaml', :path => 'db'})

# define your color class, properties are both schema for your data, instance variables, and accessor methods for working with them
class Rectangle
  include DataMapper::Resource   
  property :id,           Serial
  property :color,        String
  property :width,        Integer
  property :height,       Integer
end


# respond to GET on "/new"
# a string returned from this action will be the response
get "/new" do
  # "heredoc" syntax: everything between here and the next "HTML" is a string
  # markup for a form to create a color
  # key things: 'action' attribute defines URL this will be sent to
  # 'method' attribute defines verb it will be sent with
  # input name attributes determine what keys are in the hash on the other side
  <<-HTML
  <form method="POST" action="/rectangle">
      <p><label>Color:</label><input type="text" name="color"  /></p>
      <p><label>Width:</label><input type="text" name="width"  /></p>
      <p><label>Height</label><input type="text" name="height"  /></p>
      <p><input type="submit" value="create" /></p>
    </form>
  HTML
end

# respond to POST on "/color" (data from form above gets sent here)
post "/rectangle" do
  
  # create a new instance of the Color class
  rectangle = Rectangle.new
  
  # set each attribute from the form values (which come in as this 'params' hash)
  rectangle.color = params[:color] # pull out the value corresponding to the key 'color' in the hash
  rectangle.width = params[:width]
  rectangle.height = params[:height]
  
  # save the color object to the database/file
  rectangle.save
  
  # redirect the user to the homepage
  redirect "/"
end

# respond to a GET request on the root of the site
get "/" do
  # start a string with a link
  html = '<a href="/new">Add a color</a>'

  # loop through all the colors saved in the database
  for rectangle in Rectangle.all
      # add html with the color, width, and height attributes inserted into the style
      # heredoc syntax again
      
      html += <<-HTML
      <div style="background-color:#{rectangle.color}; 
                             width:#{rectangle.width}px; 
                             height:#{rectangle.height}px">
      </div>
      HTML
  end
  # return the full html string as the response
  html
end