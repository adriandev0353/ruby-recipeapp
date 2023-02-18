class ShoppingListsController < ApplicationController
  before_action :authenticate_user!
  def index
    @all_ingredients = RecipeFood.includes(:recipe, :food)
    @missing = @all_ingredients.select { |ing| ing.quantity > ing.foods.quantity }
    @missing_ingredients = @missing.map do |ingredient|
      {
        name: ingredient.foods.name,
        quantity: ingredient.quantity - ingredient.foods.quantity,
        price: ingredient.foods.price * (ingredient.quantity - ingredient.foods.quantity)
      }
    end
    @total_price = @missing_ingredients.map { |ing| ing[:price] }.sum
  end
end
