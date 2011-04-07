require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, 'sqlite3:///Users/greg/code/sinatra/colors.db')

class Color
  include DataMapper::Resource   
  property :id,           Serial
  property :color,        String
  property :width,        Integer
  property :height,       Integer
end

get "/new" do
  <<-HTML
  <form action="/color" method="POST">
      <p><label>Color:</label><input type="text" name="color"  /></p>
      <p><label>Width:</label><input type="text" name="width"  /></p>
      <p><label>Height</label><input type="text" name="height"  /></p>
      <p><input type="submit" value="create" /></p>
    </form>
  HTML
end

post "/color" do
  @color = Color.create :color => params[:color], 
                        :width => params[:width], 
                        :height => params[:height]
  
  redirect "/"
end

get "/" do
  html = '<a href="/new">Add a color</a>'

  for color in Color.all
      html += <<-HTML
      <div style="background-color:#{color.color}; 
                             width:#{ color.width}px; 
                             height:#{color.height}px">
      &nbsp;
      </div>
      HTML

  end
  html
end