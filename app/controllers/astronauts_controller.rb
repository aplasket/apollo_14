class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all
    @astronaut_average_age = Astronaut.average_age
  end
end