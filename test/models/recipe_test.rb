require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "hung", email: "hung@gmail.com",
               password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
  end

  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end

  test "description shouldn't be less than 5 characters" do
    @recipe.description = "a"*3
    assert_not @recipe.valid?
  end
  test "description shouldn't be more than 500 characters" do
    @recipe.description = "a"*501
    assert_not @recipe.valid?
  end

  test " password should be at least 5 character " do
    @chef.password = @chef.password_confirmation = "x"*4
    assert_not @chef.valid?
  end
end