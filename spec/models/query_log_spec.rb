require "rails_helper"

describe QueryLog do
  describe "structure and validation" do
    it "validates its validables" do
      should validate_presence_of(:ip)
      should validate_presence_of(:query)
    end
  end
end
