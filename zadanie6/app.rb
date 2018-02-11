require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'erb'
require 'pry'
require 'pry-nav'

def alive(id, alive_cells)
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
    living == 3
  end
end

def all_cells
  rows = (1..30).to_a
  columns = (1..50).to_a
  cells = rows.product columns
  cells.map {|p| "#{p.first}_#{p.last}"}
end

def evolution
  @alive_cells = {}
  @dead_cells = {}
  all_cells.each do |cell|
    if alive(cell, @alive_cells)
      @alive_cells[cell] = 'on'
    else
      @dead_cells[cell] = 'off'
    end
  end
  params = @alive_cells
end

get '/' do
  erb :start
end

post '/first' do
  # @alive_cells = params
  evolution
  erb :next
end

post '/next' do
  # @alive_cells = {}
  evolution
  erb :next
end
