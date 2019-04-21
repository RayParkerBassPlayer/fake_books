require "rails_helper"

describe Book do
  describe "structure and validation" do
    it "validates its validatables" do
      should validate_presence_of(:title)
      should validate_uniqueness_of(:title).case_insensitive
    end

    it "has its database columns" do
      should have_db_column(:title)
    end

    it "has its relationships" do
      should have_many(:locations)
      should have_many(:tunes).through(:locations)
    end
  end
end
