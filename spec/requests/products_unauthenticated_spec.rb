# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Products", type: :request do
  context "when accessing products without authentication" do
    it "allows access to the products index" do
      get products_path

      expect(response).to have_http_status(:ok)
    end

    it "allows access to an existing product" do
      product = Product.create!(name: "Test-Product")

      get product_path(product)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.name)
    end
  end
end
