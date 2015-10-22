require "rails_helper"

RSpec.describe "the user", type: :model do
  context "a user" do
    let(:user) { User.new(name: "ry", email: "ry@yeah.com", password: "ohyeah")}

    it "is valid" do
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "not a platform admin by default" do
      user = User.create(name: "name", email: "name@name.com", password: "password")
      expect(user.platform_admin?).to eq(false)
    end
  end
end
