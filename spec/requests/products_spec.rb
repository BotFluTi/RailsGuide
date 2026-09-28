# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Products", type: :request do
  it "returns status 200 when /products is accessed" do
    get "/products"

    expect(response).to have_http_status(:ok)
  end

  context "when product exists" do
    it "returns status 200 for an existing product" do
      product = Product.create!(name: "Test-Product")

      get "/products/#{product.id}"

      expect(response).to have_http_status(:ok)
    end
  end

  context "when product doesn't exist" do
    it "returns status 404 for a non-existing product" do
      get "/products/909"

      expect(response).to have_http_status(:not_found)
    end
  end

  context "when accessing the new product" do
    it "returns status 200" do
      get "/products/new"

      expect(response).to have_http_status(:ok)
    end
  end

  context "when creating a product with valid attributes" do
    it "creates a product and redirects to its page" do
      expect {
        post "/products", params: {
          product: { name: "Test-Product" }
        }
      }.to change(Product, :count).by(1)

      expect(response).to redirect_to(product_path(Product.last))
    end
  end

  context "when creating a product with invalid attributes" do
    it "does not create a product" do
      expect {
        post "/products", params: {
          product: { name: "" }
        }
      }.not_to change(Product, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
