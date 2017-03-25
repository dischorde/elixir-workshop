defmodule MyRange do
  def create(start, finish) when start < finish do
    [start | create((start + 1), finish)]
  end

  def create(start, finish) when start === finish do
    [start]
  end

  def create(start, finish) when start > finish do
    create(finish, start)
  end
end

defmodule FizzBuzz do
  def fizz_buzz(range) do
    list = Enum.to_list range
    fizz_list(list)
  end

  defp fizz_list([head | tail]) when rem(head, 3) == 0 and rem(head, 5) != 0 do
    ["Fizz" | fizz_list(tail)]
  end

  defp fizz_list([head | tail]) when rem(head, 5) == 0 and rem(head, 3) != 0 do
    ["Buzz" | fizz_list(tail)]
  end

  defp fizz_list([head | tail]) when rem(head, 15) == 0 do
    ["FizzBuzz" | fizz_list(tail)]
  end

  defp fizz_list([head | tail]) when rem(head, 5) != 0 and rem(head, 3) != 0 do
    [head | fizz_list(tail)]
  end

  defp fizz_list([]) do
    []
  end
end

defmodule MyList do
  def sum([head | tail]) do
    head + sum(tail)
  end

  def sum([]) do
    0
  end

  def my_reduce([head | tail], start, lambda) do
    so_far = lambda.(head, start)
    my_reduce(tail, so_far, lambda)
  end

  def my_reduce([], start, _) do
    start
  end

  def my_select(list, func) do
    my_select(list, func, [])
  end

  defp my_select([h | t], func, new_list) do
    if func.(h) do
      my_select(t, func, new_list ++ [h])
    else
      my_select(t, func, new_list)
    end
  end

  defp my_select([], _, new_list), do: new_list

  def my_any?([head | tail], func) do
    func.(head) or my_any?(tail, func)
  end

  def my_any?([], _) do
    false
  end
end
