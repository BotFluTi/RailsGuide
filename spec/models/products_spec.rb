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
end
