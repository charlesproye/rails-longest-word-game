require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
    test "Going to /new gives us a new random grid to play with" do
    p "Test 1"
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "The word is not in the grid" do
    p "Test 2"
    visit new_url
    fill_in "word", with: "yrt"
    click_on "Try this!"
    assert_text "You are all wrong"
  end

  test "The word is not an english word" do
    p "Test 3"
    visit new_url
    fill_in "word", with: "o"
    click_on "Try this!"
    assert_text "doesn't seem to be an English word..."
  end

  test "The word is an english word" do
    p "Test 4"
    visit new_url
    fill_in "word", with: "a"
    click_on "Try this!"
    assert_text "a valid word"
  end
end
