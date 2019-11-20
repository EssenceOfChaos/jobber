defmodule Stack do
  @moduledoc """
  Implementation of a Stack data structure
  """
  def new, do: []

  def empty?([]), do: true
  def empty?(_), do: false

  def pop([h | t]), do: {h, t}

  def push(h, t), do: [h | t]

  def top([h | _]), do: h
end

# iex(2)> stack = Stack.new
# []
# iex(3)> Stack.empty?(stack)
# true
# iex(4)> newstack = List.foldl([1,2,3,4,5], stack, fn x,acc -> Stack.push(x,acc) end)
# [5, 4, 3, 2, 1]
# iex(5)> Stack.top(newstack)
# 5
# iex(6)> {popped, poppedstack} = Stack.pop(newstack)
# {5, [4, 3, 2, 1]}
# iex(7)> Stack.empty?(newstack)
# false
