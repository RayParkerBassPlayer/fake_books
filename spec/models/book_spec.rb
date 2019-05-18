require "rails_helper"

describe Book do
  describe "structure and validation" do
    it "validates its validatables" do
      should validate_presence_of(:title)
      should validate_uniqueness_of(:title).case_insensitive
      should validate_presence_of(:offset)
    end

    it "has its database columns" do
      should have_db_column(:title)
      should have_db_column(:offset)
    end

    it "has its relationships" do
      should have_many(:locations)
      should have_many(:tunes).through(:locations)
    end

    describe "dependant locations" do
      it "destroys locations when destroyed" do
        tune = create(:tune)
        book = create(:book)
        location = create(:location, :book => book, :tune => tune)

        Book.find(book.id).destroy
        expect(Location.where(:id => location.id)).to be_empty
      end
    end
  end
end
