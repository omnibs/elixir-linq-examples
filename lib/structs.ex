defmodule Product do
  defstruct product_id: 0,product_name: "",category: "",unit_price: 0.0,units_in_stock: 0
end

defmodule Order do
  defstruct order_id: 0,order_date: "",total: 0.00
end

defmodule Customer do
  defstruct customer_id: 0,company_name: "",address: "",city: "",region: "",postal_code: "",country: "",phone: "",fax: "",orders: %Order{}
end