require "rails_helper"

describe Location do
  describe "structure and validations" do
    it "validates its validatables" do
      should validate_presence_of :book_id
      should validate_presence_of :tune_id
      should validate_presence_of :page
    end

    it "has its database columns" do
      should have_db_column(:book_id)
      should have_db_column(:tune_id)
      should have_db_column(:page)
    end

    it "has its relationships" do
      should belong_to(:book)
      should belong_to(:tune)
    end
  end
end
