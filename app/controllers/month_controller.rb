class MonthController < ApplicationController
  def index
    @months = Month.all
    puts @months
  end
end
