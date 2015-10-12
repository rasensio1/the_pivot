require "rails_helper"

RSpec.describe "the user", type: :model do
  context "a user" do
    let(:user) { Fabricate(:user) }

    it "is valid" do
      expect(user).to be_valid
    end

    it "is invalid without a username" do
      user.username = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a street name" do
      user.street_name = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a zipcode" do
      user.zipcode = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a phone number" do
      user.phone_number = nil
      expect(user).to_not be_valid
    end

    it "has a default role of 'default'" do
      expect(user.role).to eq "default"
    end

    it "has an associated zipcode" do
      expect(user.zipcode).to eq 80202
    end

    it "has an associated phone number" do
      expect(user.phone_number).to eq "5732681897"
    end
  end
end
