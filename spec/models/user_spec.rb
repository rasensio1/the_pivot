require "rails_helper"

RSpec.describe "the user", type: :model do
  let(:user) {
    User.create(username: "Ronda",
                password: "Rousey",
                zipcode: 80202,
                street_name: "1500 Blake Street",
                phone_number: "7203817045")
  }

  context "a user" do
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

    it "has a default role of 'default'" do
      expect(user.role).to eq "default"
    end

    it "has an associated zipcode" do
      expect(user.zipcode).to eq 80202
    end

    it "can get delivery" do
      expect(user.valid_delivery?).to eq true
    end

    it "can not get deliver if they live too far away" do
      user.zipcode = 22630
      user.street_name = "Front Royal"
      expect(user.valid_delivery?).to eq false
    end

    it "has an associated phone number" do
      expect(user.phone_number).to eq "7203817045"
    end
  end
end
