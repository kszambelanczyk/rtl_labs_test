# LtrLabs test

## Tax and Total Calculation

For test simplicity I used Decimal type for storing currency values and tax. But for real application the lib 'money' would be more applicable because it supports opinionated rounding rules per specific currencies types

#### Assumptions
- Calculations require three input values: `net_price`, `quantity`, and `tax_rate`
- `tax_rate` was not specified in the original task description but was added as a necessary parameter to properly calculate the total with tax
- `tax_rate` is provided as a percentage value (e.g., 5 for 5%)

The application handles tax and total calculations through two main modules:

### OrderItem Module

The `OrderItem` module calculates totals for individual order items:
- `calculate_totals/1` computes:
  - `net_total`: net_price × quantity
  - Tax amount: (net_total × tax_rate) ÷ 100
  - `total`: net_total + tax amount (rounded to 2 decimal places)

### Order Module

The `Order` module calculates overall order totals:
- `calculate_total_and_tax/1` processes all order items to compute:
  - Updates each order item using `OrderItem.calculate_totals/1`
  - Aggregates all items' net_total and total values
  - Calculates tax as the difference between total and net_total

### Example Usage

The calculations can be run as shown in the tests:

```elixir
# Create order items
order_item = OrderItem.new(name: "item 1", net_price: 100, tax_rate: 5, quantity: 3)
calculated_item = OrderItem.calculate_totals(order_item)

# Create and calculate a complete order
order = %Order{order_items: [order_item1, order_item2, order_item3]}
calculated_order = Order.calculate_total_and_tax(order)
```

See `test/order_test.exs` and `test/order_item_test.exs` for complete examples.

