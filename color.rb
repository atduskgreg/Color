require 'dm-core'

#DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.setup(:default, 'sqlite:////Users/greg/code/sinatra/sqlite3.db')

class Color
#  attr_accessor :hex_value, :width, :height
  include DataMapper::Resource   
  property :id,           Serial
  property :hex_value,    String
  property :width,        Integer
  property :height,       Integer
  
  def html
    <<-ANYTHING
    <div style="width:#{width}px; background-color:##{hex_value}; height:#{height}px">
    &nbsp;
    </div>
    ANYTHING
  end
end