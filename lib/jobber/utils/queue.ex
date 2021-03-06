defmodule Jobber.Utils.Queue do
  @moduledoc """
  Implementing a FIFO Queue data structure
  """
  def empty?([]), do: true
  def empty?(_), do: false

  def pop([h | t]), do: {h, t}

  def push(q, t), do: q ++ [t]

  def front([h | _]), do: h
end

# iex(2)> q = [1,2,3,4,5]
# [1, 2, 3, 4, 5]
# iex(3)> Queue.push(q,10)
# [1, 2, 3, 4, 5, 10]
# iex(4)> front=Queue.front(q)
# 1
# iex(5)> Queue.empty?(q)
# false
# iex(6)> Queue.pop(q)
# {1, [2, 3, 4, 5]}
# iex(7)> l=[]
# []
# iex(8)> Queue.empty?(l)
# true
