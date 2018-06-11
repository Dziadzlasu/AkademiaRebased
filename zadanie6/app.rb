require 'bundler'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'erb'

Bundler.require(:default)

def alive(id)
  row, column = id.split('_')
  row = row.to_i
  column = column.to_i
  neighbors = ["#{(row - 1)}_#{(column - 1)}", "#{(row - 1)}_#{column}", "#{(row - 1)}_#{(column + 1)}",
               "#{row}_#{(column - 1)}", "#{row}_#{(column + 1)}",
               "#{(row + 1)}_#{(column - 1)}", "#{(row + 1)}_#{column}", "#{(row + 1)}_#{(column + 1)}"]
  neighbors_alive = neighbors.select do |cell|
    params.include?(cell)
  end
  living = neighbors_alive.size
  if params.include?(id)
    true unless living < 2 || living > 3
  else
    living == 3
  end
end

def all_cells
  rows = (1..30).to_a
  columns = (1..50).to_a
  cells = rows.product columns
  cells.map { |p| "#{p.first}_#{p.last}" }
end

def evolution
  @alive_cells = {}
  @dead_cells = {}
  all_cells.each do |cell|
    if alive(cell)
      @alive_cells[cell] = 'on'
    else
      @dead_cells[cell] = 'off'
    end
  end
end

get '/' do
  erb :start
end

post '/next' do
  evolution
  erb :next
end
