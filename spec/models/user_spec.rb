require "rails_helper"

RSpec.describe User, type: :model do
  context "when managing a user" do
    before do
      @user = User.create!(email_address: "test@example.com", password: "password123")
    end

    it "authenticates with the correct password" do
      expect(@user.authenticate("password123")).to eq(@user)
      expect(@user.authenticate("wrongpassword")).to be_falsey
    end

    it "normalizes the email address" do
      @user.update!(email_address: "  TEST@EXAMPLE.COM  ")

      expect(@user.email_address).to eq("test@example.com")
    end

    it "destroys associated sessions when the user is destroyed" do
      @user.sessions.create!

      expect {
        @user.destroy!
      }.to change(Session, :count).by(-1)
    end
  end
end
