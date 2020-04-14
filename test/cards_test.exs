# In Elixir there are two types of tests:
#  - Usual specific case tests
#  - Doctesting: while writing documentation, tests are created

defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 20
  end

  # Not the best test because there would be a possibility that the shuffled deck is the exact same as the origimnal one
  test "shuffling a deck randomises it" do
    deck = Cards.create_deck()
    assert deck != Cards.shuffle(deck)
    # refute deck == Cards.shuffle(deck) => does the same thing
  end
end
