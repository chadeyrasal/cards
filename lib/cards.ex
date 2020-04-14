# The defmodule command defines a module
# In Elixir, nearly all code will be written inside modules
# A module is a collection of different methods or functions

# Single quotes are supported but the convention is to use double quotes.

# In functions, there can be no return keyword. Elixir has an implicit return value. Whatever the last line of a function
# is will be the return value of that function.

# Elixir has a lot of standard methods that allow you to work with lists, numbers, your file system, HTTP requests...

# The concept of iummutability in Elixir that everytime a data structure is changed, it is actually a copy of the original
# data structure that is modified according to need. A data structure cannot be mutated.

defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  @doc """
    Returns a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # This is a list comprehension, sort of a for loop. For every element in the list do what is written in the block
    # The comprehension is essentially a mapping function: so every single time we take an item out of our list -
    # suits here - it is passed in the do block.
    # Whatever is returned from the do block is placed into a brand new array.
    # Whatever the final array is, it is the returned value from the comprehension.
    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  # Arity is the number of arguments that a function accepts
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  # Pattern matching is Elixir's replacement for variable assignment
  # Pattern matching is used everytime we use the = sign

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> { hand, deck } = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  # When we see a column before a word in Elixir, it is a primitive data type called atom
  # Atoms in Elixir are used to manage control flow, like error messages or status codes
  # The difference between an atom and a string is that strings are a bunch of info that can be passed on
  # to the user, whereas an atom is a bunch of information that only developers should see.
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "This file does not exist"
    end
  end

  # The pipe operator uses the return value of the previous method call as the first argument for the following one
  # You need to make sure that your methods are declared with arguments in the appropriate order to be able to
  # use the pipe operator and chain method calls.
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
