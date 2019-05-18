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

  describe "page with offset" do
    it "returns its page without offset" do
      book = create(:book, :offset => 9)
      tune = create(:tune)
      location = create(:location, :tune => tune, :book => book, :page => 10)

      expect(location.page).to eq 10
    end

    it "returns its page with offset" do
      offset = 9
      page = 10
      book = create(:book, :offset => offset)
      tune = create(:tune)
      location = create(:location, :tune => tune, :book => book, :page => page)

      expect(location.pdf_page).to eq ( page + offset)    
    end
  end
end
