require "rails_helper"

describe IRealFile do
  describe "structure and validation" do
    it "has its relationship" do
      should belong_to(:tune)
    end

    it "validates its validatables" do
      should validate_presence_of(:tune_id)
      should validate_presence_of(:song_hash)
    end

    it "has its database columns" do
      should have_db_column(:tune_id)
      should have_db_column(:song_hash)
    end

    it "validates format of json file" do

    end
  end
end
