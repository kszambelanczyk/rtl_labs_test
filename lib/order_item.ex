defmodule LtrLabs.OrderItem do
  @moduledoc """
  Represents an item in an order.

  ## Attributes

  * `name` - The name of the item.
  * `net_price` - The net price of the item - this is given in the order.
  * `tax_rate` - The tax rate of the item in percent - this is given in the order (missing part of the spec).
  * `quantity` - The quantity of the item - this is given in the order.
  * `net_total` - The net total of the item - this is calculated.
  * `total` - The total of the item - this is calculated.
  """

  alias Decimal, as: D

  defstruct [:name, :net_price, :tax_rate, :quantity, :net_total, :total]

  def new(name: name, net_price: net_price, tax_rate: tax_rate, quantity: quantity) do
    %__MODULE__{
      name: name,
      net_price: D.new(net_price),
      tax_rate: D.new(tax_rate),
      quantity: quantity
    }
  end

  def calculate_totals(%__MODULE__{net_price: net_price, tax_rate: tax_rate, quantity: quantity} = order_item) do
    net_total = D.mult(net_price, quantity)
    tax_total = D.div(D.mult(net_total, tax_rate), 100)
    total = D.round(D.add(net_total, tax_total), 2)

    %{order_item | net_total: net_total, total: total}
  end
end
