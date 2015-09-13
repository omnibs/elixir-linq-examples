defmodule Product do
  defstruct product_id: 0,product_name: "",category: "",unit_price: 0.0,units_in_stock: 0
end

defmodule Order do
  @derive [Poison.Encoder]
  defstruct order_id: 0,order_date: "",total: 0.00
end

defmodule OrderList do
  @derive [Poison.Encoder]
  defstruct order: [%Order{}]
end

defmodule Customer do
  @derive [Poison.Encoder]
  defstruct id: 0,name: "",address: "",city: "",region: "",postalcode: "",country: "",phone: "",fax: "",orders: %OrderList{}
end

# defmodule Order do
#   @derive [Poison.Encoder]
#   defstruct [:id, :orderdate, :total]
# end

# defmodule OrderList do
#   @derive [Poison.Encoder]
#   defstruct [:order]
# end

# defmodule Customer do
#   @derive [Poison.Encoder]
#   defstruct [:id, :name, :address, :city, :region, :postalcode, :country, :phone, :fax, :orders]
# end