class Recipe
  attr_reader :name, :description
  attr_accessor :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @made = false
  end

  def made?
    @made
  end

  def made!
    @made = !@made
  end
end
