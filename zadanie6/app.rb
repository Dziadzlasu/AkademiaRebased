require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'erb'
require 'pry'
require 'pry-nav'

def alive(id)
  row, column = id.split('_')
  row = row.to_i
  column = column.to_i
  neighbors = [ "#{(row - 1) }_#{(column - 1)}", "#{(row - 1)}_#{column}", "#{(row - 1)}_#{(column + 1)}",
  "#{row}_#{(column - 1)}", "#{row}_#{(column + 1)}", "#{(row + 1)}_#{(column - 1)}",
  "#{(row + 1)}_#{column}", "#{(row + 1)}_#{(column + 1)}"]
  neighbors_alive = neighbors.select do |cell|
    params.include?(cell)
  end
  living = neighbors_alive.size
  if params.include?(id)
    if living < 2
      false
    elsif living == 2 || living == 3
      true
    elsif living > 3
      false
    end
  else
    if living == 3
      true
    else
      false
    end
  end
end

def all_cells
  rows = (1..30).to_a
  columns = (1..50).to_a
  cells = rows.product columns
  cells.map {|p| "#{p.first}_#{p.last}"}
end

get '/' do
  erb :start
end

post '/first' do
  all_cells.each do |cell|
    # cell = param
    # binding.pry
    if alive(cell)
      params[cell] = "on"
    else
      # params.delete cell
    end
  end
  # binding.pry
  erb :next
end

post '/next' do
  erb :next
end
