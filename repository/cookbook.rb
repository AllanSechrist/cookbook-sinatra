
require "csv"
require_relative "../models/recipe"
class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @recipes = []
    @file = csv_file_path
    load_csv if File.exist?(@file)
  end

  def all
    @recipes
  end

  def create(recipe)
    @recipes << Recipe.new(recipe)
    save_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_as_made(recipe_index)
    @recipes[recipe_index].made!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@file, headers: :first_row, header_converters: :symbol) do |recipe|
      # info = {
      #   name: recipe[0],
      #   description: recipe[1],
      #   rating: recipe[2],
      #   prep_time: recipe[3],
      #   made: recipe[4]
      # }
      recipe[:rating] = recipe[:rating].to_f
      recipe[:made] = recipe[:made] == "true"
      @recipes << Recipe.new(recipe)
    end
  end

  def save_csv
    CSV.open(@file, "wb") do |csv|
      headers = ["name", "description", "rating", "prep_time", "made"]
      csv << headers
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.made?]
      end
    end
  end
end
