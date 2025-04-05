defmodule LtrLabs.OrderItemTest do
  use ExUnit.Case

  alias Decimal, as: D
  alias LtrLabs.OrderItem

  describe "calculate_totals/1" do
    test "returns the net_total and total for an order_item" do
      order_item =
        [name: "item 1", net_price: 100, tax_rate: 5, quantity: 3]
        |> OrderItem.new()
        |> OrderItem.calculate_totals()

      assert D.to_integer(order_item.total) == 315
      assert D.to_integer(order_item.net_total) == 300
    end
  end
end
