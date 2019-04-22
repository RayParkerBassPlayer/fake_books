require "rails_helper"

describe "QueryLogging" do
  it "tracks a query when a post to #find is make" do
    visit root_path

    fill_in :search_string, :with => "A Song Name"
    expect{click_button "Find"}.to change{QueryLog.count}.by(1)
  end

  it "does not track a get to #home" do
    expect{visit root_path}.not_to change{QueryLog.count}
  end

  it "does not track a get to #find" do
    expect{visit find_tune_path}.not_to change{QueryLog.count}
  end
end
