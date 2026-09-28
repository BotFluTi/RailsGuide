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
end
