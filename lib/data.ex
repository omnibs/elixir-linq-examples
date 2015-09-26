defmodule ElixirLinqExamples.Data do
  def get_customer_list() do
    Agent.get(__MODULE__, &(&1))
  end

  @doc """
  Creates an agent that caches the list of customers. Reading them in every test made the tests run too slot.
  """
  def cache_customer_list() do
    Agent.start_link(fn -> read_customer_list() end, name: __MODULE__)
  end

  defp read_customer_list() do
    {:ok, json} = File.read "resources/Customers.json"
    decoded = Poison.decode!(json, keys: :atoms).customers
    decoded |> Enum.map(&map_customer/1)
  end

  defp map_customer(x) do
    customer = struct(Customer, x)

    if customer.orders != nil && customer.orders.order != nil do
      orders = Enum.map(customer.orders.order, fn o -> 
            o = struct(Order, o)
            {:ok, orderdate} = Timex.DateFormat.parse(o.orderdate, "{ISOz}")
            %{ o | orderdate: orderdate}
      end)
      %{customer | orders: orders}
    else
      %{customer | orders: []}
    end
  end
  def get_product_list() do
    [
      %Product{ product_id: 1, product_name: "Chai", category: "Beverages", unit_price: 18.000, units_in_stock: 39 },
      %Product{ product_id: 2, product_name: "Chang", category: "Beverages", unit_price: 19.000, units_in_stock: 17 },
      %Product{ product_id: 3, product_name: "Aniseed Syrup", category: "Condiments", unit_price: 10.000, units_in_stock: 13 },
      %Product{ product_id: 4, product_name: "Chef Anton's Cajun Seasoning", category: "Condiments", unit_price: 22.000, units_in_stock: 53 },
      %Product{ product_id: 5, product_name: "Chef Anton's Gumbo Mix", category: "Condiments", unit_price: 21.350, units_in_stock: 0 },
      %Product{ product_id: 6, product_name: "Grandma's Boysenberry Spread", category: "Condiments", unit_price: 25.000, units_in_stock: 120 },
      %Product{ product_id: 7, product_name: "Uncle Bob's Organic Dried Pears", category: "Produce", unit_price: 30.000, units_in_stock: 15 },
      %Product{ product_id: 8, product_name: "Northwoods Cranberry Sauce", category: "Condiments", unit_price: 40.000, units_in_stock: 6 },
      %Product{ product_id: 9, product_name: "Mishi Kobe Niku", category: "Meat/Poultry", unit_price: 97.000, units_in_stock: 29 },
      %Product{ product_id: 10, product_name: "Ikura", category: "Seafood", unit_price: 31.000, units_in_stock: 31 },
      %Product{ product_id: 11, product_name: "Queso Cabrales", category: "Dairy Products", unit_price: 21.000, units_in_stock: 22 },
      %Product{ product_id: 12, product_name: "Queso Manchego La Pastora", category: "Dairy Products", unit_price: 38.000, units_in_stock: 86 },
      %Product{ product_id: 13, product_name: "Konbu", category: "Seafood", unit_price: 6.000, units_in_stock: 24 },
      %Product{ product_id: 14, product_name: "Tofu", category: "Produce", unit_price: 23.250, units_in_stock: 35 },
      %Product{ product_id: 15, product_name: "Genen Shouyu", category: "Condiments", unit_price: 15.500, units_in_stock: 39 },
      %Product{ product_id: 16, product_name: "Pavlova", category: "Confections", unit_price: 17.450, units_in_stock: 29 },
      %Product{ product_id: 17, product_name: "Alice Mutton", category: "Meat/Poultry", unit_price: 39.000, units_in_stock: 0 },
      %Product{ product_id: 18, product_name: "Carnarvon Tigers", category: "Seafood", unit_price: 62.500, units_in_stock: 42 },
      %Product{ product_id: 19, product_name: "Teatime Chocolate Biscuits", category: "Confections", unit_price: 9.200, units_in_stock: 25 },
      %Product{ product_id: 20, product_name: "Sir Rodney's Marmalade", category: "Confections", unit_price: 81.000, units_in_stock: 40 },
      %Product{ product_id: 21, product_name: "Sir Rodney's Scones", category: "Confections", unit_price: 10.000, units_in_stock: 3 },
      %Product{ product_id: 22, product_name: "Gustaf's Knäckebröd", category: "Grains/Cereals", unit_price: 21.000, units_in_stock: 104 },
      %Product{ product_id: 23, product_name: "Tunnbröd", category: "Grains/Cereals", unit_price: 9.000, units_in_stock: 61 },
      %Product{ product_id: 24, product_name: "Guaraná Fantástica", category: "Beverages", unit_price: 4.500, units_in_stock: 20 },
      %Product{ product_id: 25, product_name: "NuNuCa Nuß-Nougat-Creme", category: "Confections", unit_price: 14.000, units_in_stock: 76 },
      %Product{ product_id: 26, product_name: "Gumbär Gummibärchen", category: "Confections", unit_price: 31.230, units_in_stock: 15 },
      %Product{ product_id: 27, product_name: "Schoggi Schokolade", category: "Confections", unit_price: 43.900, units_in_stock: 49 },
      %Product{ product_id: 28, product_name: "Rössle Sauerkraut", category: "Produce", unit_price: 45.600, units_in_stock: 26 },
      %Product{ product_id: 29, product_name: "Thüringer Rostbratwurst", category: "Meat/Poultry", unit_price: 123.790, units_in_stock: 0 },
      %Product{ product_id: 30, product_name: "Nord-Ost Matjeshering", category: "Seafood", unit_price: 25.890, units_in_stock: 10 },
      %Product{ product_id: 31, product_name: "Gorgonzola Telino", category: "Dairy Products", unit_price: 12.500, units_in_stock: 0 },
      %Product{ product_id: 32, product_name: "Mascarpone Fabioli", category: "Dairy Products", unit_price: 32.000, units_in_stock: 9 },
      %Product{ product_id: 33, product_name: "Geitost", category: "Dairy Products", unit_price: 2.500, units_in_stock: 112 },
      %Product{ product_id: 34, product_name: "Sasquatch Ale", category: "Beverages", unit_price: 14.000, units_in_stock: 111 },
      %Product{ product_id: 35, product_name: "Steeleye Stout", category: "Beverages", unit_price: 18.000, units_in_stock: 20 },
      %Product{ product_id: 36, product_name: "Inlagd Sill", category: "Seafood", unit_price: 19.000, units_in_stock: 112 },
      %Product{ product_id: 37, product_name: "Gravad lax", category: "Seafood", unit_price: 26.000, units_in_stock: 11 },
      %Product{ product_id: 38, product_name: "Côte de Blaye", category: "Beverages", unit_price: 263.500, units_in_stock: 17 },
      %Product{ product_id: 39, product_name: "Chartreuse verte", category: "Beverages", unit_price: 18.000, units_in_stock: 69 },
      %Product{ product_id: 40, product_name: "Boston Crab Meat", category: "Seafood", unit_price: 18.400, units_in_stock: 123 },
      %Product{ product_id: 41, product_name: "Jack's New England Clam Chowder", category: "Seafood", unit_price: 9.650, units_in_stock: 85 },
      %Product{ product_id: 42, product_name: "Singaporean Hokkien Fried Mee", category: "Grains/Cereals", unit_price: 14.000, units_in_stock: 26 },
      %Product{ product_id: 43, product_name: "Ipoh Coffee", category: "Beverages", unit_price: 46.000, units_in_stock: 17 },
      %Product{ product_id: 44, product_name: "Gula Malacca", category: "Condiments", unit_price: 19.450, units_in_stock: 27 },
      %Product{ product_id: 45, product_name: "Rogede sild", category: "Seafood", unit_price: 9.500, units_in_stock: 5 },
      %Product{ product_id: 46, product_name: "Spegesild", category: "Seafood", unit_price: 12.000, units_in_stock: 95 },
      %Product{ product_id: 47, product_name: "Zaanse koeken", category: "Confections", unit_price: 9.500, units_in_stock: 36 },
      %Product{ product_id: 48, product_name: "Chocolade", category: "Confections", unit_price: 12.750, units_in_stock: 15 },
      %Product{ product_id: 49, product_name: "Maxilaku", category: "Confections", unit_price: 20.000, units_in_stock: 10 },
      %Product{ product_id: 50, product_name: "Valkoinen suklaa", category: "Confections", unit_price: 16.250, units_in_stock: 65 },
      %Product{ product_id: 51, product_name: "Manjimup Dried Apples", category: "Produce", unit_price: 53.000, units_in_stock: 20 },
      %Product{ product_id: 52, product_name: "Filo Mix", category: "Grains/Cereals", unit_price: 7.000, units_in_stock: 38 },
      %Product{ product_id: 53, product_name: "Perth Pasties", category: "Meat/Poultry", unit_price: 32.800, units_in_stock: 0 },
      %Product{ product_id: 54, product_name: "Tourtière", category: "Meat/Poultry", unit_price: 7.450, units_in_stock: 21 },
      %Product{ product_id: 55, product_name: "Pâté chinois", category: "Meat/Poultry", unit_price: 24.000, units_in_stock: 115 },
      %Product{ product_id: 56, product_name: "Gnocchi di nonna Alice", category: "Grains/Cereals", unit_price: 38.000, units_in_stock: 21 },
      %Product{ product_id: 57, product_name: "Ravioli Angelo", category: "Grains/Cereals", unit_price: 19.500, units_in_stock: 36 },
      %Product{ product_id: 58, product_name: "Escargots de Bourgogne", category: "Seafood", unit_price: 13.250, units_in_stock: 62 },
      %Product{ product_id: 59, product_name: "Raclette Courdavault", category: "Dairy Products", unit_price: 55.000, units_in_stock: 79 },
      %Product{ product_id: 60, product_name: "Camembert Pierrot", category: "Dairy Products", unit_price: 34.000, units_in_stock: 19 },
      %Product{ product_id: 61, product_name: "Sirop d'érable", category: "Condiments", unit_price: 28.500, units_in_stock: 113 },
      %Product{ product_id: 62, product_name: "Tarte au sucre", category: "Confections", unit_price: 49.300, units_in_stock: 17 },
      %Product{ product_id: 63, product_name: "Vegie-spread", category: "Condiments", unit_price: 43.900, units_in_stock: 24 },
      %Product{ product_id: 64, product_name: "Wimmers gute Semmelknödel", category: "Grains/Cereals", unit_price: 33.250, units_in_stock: 22 },
      %Product{ product_id: 65, product_name: "Louisiana Fiery Hot Pepper Sauce", category: "Condiments", unit_price: 21.050, units_in_stock: 76 },
      %Product{ product_id: 66, product_name: "Louisiana Hot Spiced Okra", category: "Condiments", unit_price: 17.000, units_in_stock: 4 },
      %Product{ product_id: 67, product_name: "Laughing Lumberjack Lager", category: "Beverages", unit_price: 14.000, units_in_stock: 52 },
      %Product{ product_id: 68, product_name: "Scottish Longbreads", category: "Confections", unit_price: 12.500, units_in_stock: 6 },
      %Product{ product_id: 69, product_name: "Gudbrandsdalsost", category: "Dairy Products", unit_price: 36.000, units_in_stock: 26 },
      %Product{ product_id: 70, product_name: "Outback Lager", category: "Beverages", unit_price: 15.000, units_in_stock: 15 },
      %Product{ product_id: 71, product_name: "Flotemysost", category: "Dairy Products", unit_price: 21.500, units_in_stock: 26 },
      %Product{ product_id: 72, product_name: "Mozzarella di Giovanni", category: "Dairy Products", unit_price: 34.800, units_in_stock: 14 },
      %Product{ product_id: 73, product_name: "Röd Kaviar", category: "Seafood", unit_price: 15.000, units_in_stock: 101 },
      %Product{ product_id: 74, product_name: "Longlife Tofu", category: "Produce", unit_price: 10.000, units_in_stock: 4 },
      %Product{ product_id: 75, product_name: "Rhönbräu Klosterbier", category: "Beverages", unit_price: 7.750, units_in_stock: 125 },
      %Product{ product_id: 76, product_name: "Lakkalikööri", category: "Beverages", unit_price: 18.000, units_in_stock: 57 },
      %Product{ product_id: 77, product_name: "Original Frankfurter grüne Soße", category: "Condiments", unit_price: 13.000, units_in_stock: 32 }
    ]
  end
end