defmodule Shopify do
  use HTTPoison.Base
  import Inflex

  defstruct domain: "", token: ""

  [
    :application_charges, :articles, :assets, :blogs, :carrier_services, :checkouts,
    :collects, :comments, :countries, :custom_collections, :customers, :customer_groups,
    :customer_saved_searches, :events, :fulfillments, :fulfillment_services, :gift_cards,
    :locations, :metafields, :orders, :pages, :products, :products, :images, :products,
    :variants, :provinces, :recurring_application_charges, :redirects, :refunds, :script_tags,
    :shop, :smart_collections, :themes, :transactions, :userplus, :webhooks
  ] |> Enum.each fn name ->
    def unquote(:"#{name}")(client) do
      url = "https://#{client.domain}/admin/#{unquote(name)}"
      json = request!(:get, url, "", ["x-shopify-access-token": client.token])

      json.body["#{unquote(name)}"]
    end

    def unquote(:"#{singularize(name)}")(id, client) do
      url = "https://#{client.domain}/admin/#{unquote(name)}/#{id}"
      json = request!(:get, url, "", ["x-shopify-access-token": client.token])

      json.body["#{unquote(singularize(name))}"]
    end

    def unquote(:"create_#{singularize(name)}")(args, client) do
      url = "https://#{client.domain}/admin/#{unquote(name)}"
      json_args = Poison.encode!(%{unquote(singularize(name)) => args})
      json = request!(:post, url, json_args, ["x-shopify-access-token": client.token])

      json.body["#{unquote(singularize(name))}"]
    end

    def unquote(:"update_#{singularize(name)}")(id, args, client) do
      url = "https://#{client.domain}/admin/#{unquote(name)}/#{id}"
      json_args = Poison.encode!(%{unquote(singularize(name)) => args})
      json = request!(:put, url, json_args, ["x-shopify-access-token": client.token])
      json.body["#{unquote(singularize(name))}"]
    end

    def unquote(:"destroy_#{singularize(name)}")(id, client) do
      url = "https://#{client.domain}/admin/#{unquote(name)}/#{id}"
      request!(:delete, url, "", ["x-shopify-access-token": client.token])
    end
  end

  def process_request_headers(headers) do
    [
      {'content-type', 'application/json'}, {'accept', 'application/json'} | headers
    ]
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end
end
