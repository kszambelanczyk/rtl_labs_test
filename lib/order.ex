defmodule LtrLabs.Order do
  @moduledoc """
  Represents an order.

  ## Attributes

  * `order_items` - The items in the order.
  * `tax` - The tax for the order.
  * `net_total` - The net total for the order.
  * `total` - The total for the order.
  """

  alias Decimal, as: D
  alias LtrLabs.OrderItem

  defstruct [:order_items, :tax, :net_total, :total]

  def calculate_total_and_tax(%__MODULE__{order_items: order_items} = order) do
    {items, [net_total, total]} =
      Enum.map_reduce(order_items, [0, 0], fn order_item, [net_total, total] ->
        order_item = OrderItem.calculate_totals(order_item)
        net_total = D.add(net_total, order_item.net_total)
        total = D.add(total, order_item.total)

        {order_item, [net_total, total]}
      end)

    tax = D.sub(total, net_total)

    %{order | order_items: items, net_total: net_total, total: total, tax: tax}
  end
end
