# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Products", type: :request do
  before do
    user = User.create!(email_address: "test@example.com", password: "password123")
    post session_path, params: {
      email_address: user.email_address,
      password: "password123"
    }
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
      expect(response.body).to include("<form")
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

      follow_redirect!

      expect(response.body).to include("Test-Product")
    end
  end

  context "when creating a product with invalid attributes" do
    it "does not create a product" do
      expect {
        post "/products", params: {
          product: { name: "" }
        }
      }.not_to change(Product, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  context "when accessing the product edit form" do
    it "displays the product name" do
      product = Product.create!(name: "Test-Product")

      get "/products/#{product.id}/edit"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.name)
    end

    it "returns status 404 for a non-existing product" do
      get "/products/909/edit"

      expect(response).to have_http_status(:not_found)
    end
  end

  context "when updating a product" do
    it "updates the product with valid attributes" do
      product = Product.create!(name: "Test-Product")

      put "/products/#{product.id}", params: {
        product: { name: "Updated-Product" }
      }

      expect(product.reload.name).to eq("Updated-Product")
      expect(response).to redirect_to(product_path(product))
    end

    it "does not update the product with invalid attributes" do
      product = Product.create!(name: "Test-Product")

      put "/products/#{product.id}", params: {
        product: { name: "" }
      }

      expect(product.reload.name).to eq("Test-Product")
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  context "when deleting a product" do
    it "deletes an existing product" do
      product = Product.create!(name: "Test-Product")

      expect {
        delete "/products/#{product.id}"
      }.to change(Product, :count).by(-1)

      expect(response).to redirect_to(products_path)
    end

    it "returns status 404 for a non-existing product" do
      delete "/products/909"

      expect(response).to have_http_status(:not_found)
    end
  end
end
