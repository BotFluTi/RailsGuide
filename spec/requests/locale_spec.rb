require "rails_helper"

RSpec.describe "Locale", type: :request do
  context "when switching locale" do
    it "displays the page in English" do
      get products_path(locale: :en)

      expect(response.body).to include("Hello world")
    end

    it "displays the page in Romanian" do
      get products_path(locale: :ro)

      expect(response.body).to include("Salut lume")
    end
  end
end
