require 'rails_helper'

RSpec.describe User do
  describe ".user_signups" do
    it "valids signup information" do
      user_signups = user_1(name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password")

    results = User.user_signups

    user_signups.each do |user_signup|
      expect(results).to include(user_signup)
        end
      end
    end
  end
