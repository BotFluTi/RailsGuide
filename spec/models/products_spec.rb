# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  context "when product has a name" do
    it "is valid" do
      product = Product.new(name: "Valid-Name")

      expect(product).to be_valid
    end
  end

  context "when product has no name" do
    it "is not valid" do
      product = Product.new(name: nil)

      expect(product).not_to be_valid
    end
  end

  context "when product has an image" do
    it "has an attached image" do
      product = Product.create!(name: "Test-Product")
      image = fixture_file_upload("spec/fixtures/test_image.png", "image/png")

      product.featured_image.attach(image)

      expect(product.featured_image).to be_attached
    end
  end
end
