# Shopify

**Experimental Shopify API Client for Elixir**

## Description

Shopify API implementation in Elixir. Written as an experiment by an Elixir novice. Highly simplistic, zero error-handling, no tests. ~50 LOC in a single file.

Read the code first. Use at your own risk. Don't use in production.

## Installation

To install this package:

  1. Add `shopify` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [ {:shopify, git: "https://github.com/themgt/shopify.git"} ]
    end
    ```

  2. Ensure `shopify` is started before your application:

    ```elixir
    def application do
      [applications: [:shopify]]
    end
    ```

## Example Usage

All Shopify first-level API endpoints should be available (nested / non-standard endpoints: not yet)

```elixir
s = %Shopify{domain: "test-shop.myshopify.com", token: "abcdefg"}

# GET https://test-shop.myshopify.com/admin/shop
Shopify.shop(s)

# GET https://test-shop.myshopify.com/admin/orders
Shopify.orders(s)

# GET https://test-shop.myshopify.com/admin/order/12345678910
Shopify.order(12345678910, s)

Shopify.product(12345678910, s)["title"]
Shopify.carrier_services(s)
Shopify.customers(s)
Shopify.webhooks(s)

# PUT https://test-shop.myshopify.com/admin/product/12345678910
Shopify.update_product(12345678910, %{title: "A Great Title"}, s)

# DELETE https://test-shop.myshopify.com/admin/product/12345678910
Shopify.destroy_product(12345678910, s)

Shopify.destroy_customer(12345678910, s)
```
