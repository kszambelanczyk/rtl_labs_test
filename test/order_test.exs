defmodule LtrLabs.OrderTest do
  use ExUnit.Case

  alias Decimal, as: D
  alias LtrLabs.Order
  alias LtrLabs.OrderItem

  describe "calculate_total_and_tax/1" do
    setup do
      order_item1 = OrderItem.new(name: "item 1", net_price: 100, tax_rate: 5, quantity: 1)
      order_item2 = OrderItem.new(name: "item 2", net_price: 145, tax_rate: 10, quantity: 4)
      order_item3 = OrderItem.new(name: "item 3", net_price: 874, tax_rate: 15, quantity: 3)

      order = %Order{
        order_items: [order_item1, order_item2, order_item3]
      }

      %{order: order}
    end

    test "returns the total and tax for an order", %{order: order} do
      order = Order.calculate_total_and_tax(order)
      assert D.to_float(order.total) == 3758.3
      assert D.to_integer(order.net_total) == 3302
      assert D.to_float(order.tax) == 456.3
    end
  end
end
