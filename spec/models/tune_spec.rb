require "rails_helper"

describe Tune do
  describe "structure and validation" do
    it "has its database columns" do
      should have_db_column(:title)
    end

    it "validates its validatables" do
      should validate_presence_of(:title)
      should validate_uniqueness_of(:title).case_insensitive
    end

    it "has it relationships" do
      should_not belong_to(:book)
      should have_many(:locations)
      should have_many(:books).through(:locations)
    end
  end

  describe "adding tunes" do
    it "creates a new entry if the tunes doesn't exist" do
      expect{Tune.add_tune!(:title => FFaker::Music.song + SecureRandom.hex)}.to change{Tune.count}.by(1)
    end

    it "finds an entry if the tune exists" do
      tune = create(:tune)

      expect{Tune.add_tune!(:title => tune.title)}.not_to change{Tune.count}
    end

    context "and the tune already exists" do
      it "is case insensitive" do
        tune = create(:tune)
        
        expect{Tune.add_tune!(:title => tune.title.upcase)}.not_to change{Tune.count}
      end

      it "creates a book and location if the book doesn't exist" do
        tune = create(:tune)

        expect{tune.add_location!({:page => 30, :book => FFaker::Book.title})}.to change{Book.count}.by(1)
      end

      it "doesn't create a book by adding a location if it exists" do
        tune = create(:tune)
        book = create(:book)

        expect{tune.add_location!(page: 30, book: book)}.not_to change{Book.count}
      end

      it "doesn't create a book or location if they already exist" do
        tune = create(:tune)
        title = create(:book).title
        page = 30
        
        tune.add_location!({:page => page, :book => title})

        expect{tune.add_location!(page: page, book: title)}.not_to change{Book.count}
        expect{tune.add_location!(page: page, book: title)}.not_to change{Location.count}
      end
    end
  end

  describe "add locations" do
    it "must have both a page and a book" do
      tune = create(:tune)

      expect{tune.add_location!({:page => nil, :book => FFaker::Book.title})}.to raise_error(ArgumentError)
      expect{tune.add_location!({:page => 30, :book => nil})}.to raise_error(ArgumentError)
    end
  end
end
