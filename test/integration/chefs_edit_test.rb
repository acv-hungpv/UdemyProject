require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "hung", email: "hungphan@gmail.com",password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "hung2", email: "hungphan2@gmail.com",password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "hung3", email: "hungphan3@gmail.com",password: "password", password_confirmation: "password", admin: true)
    
  end

  test "reject an invalid edit" do 
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: " ", email: " hungphan@gmail.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: "hung", email: "hungphan@gmail.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "hung",@chef.chefname
    assert_match "hungphan@gmail.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: "hung4", email: "hungphan4@gmail.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "hung4",@chef.chefname
    assert_match "hungphan4@gmail.com", @chef.email     

  end

  test "redirect edit attempt by another non-admin user" do 
    sign_in_as(@chef2, "password")
    #get edit_chef_path(@chef)
    #assert_template 'chefs/edit'
    updated_name = "joe"
    updated_email = "joe@gmail.com"

    patch chef_path(@chef), params: { chef: {chefname: updated_name, email: updated_email}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "hung",@chef.chefname
    assert_match "hungphan@gmail.com", @chef.email

  end 
end
