require 'rails_helper'

describe "create new app" do
  it "can create new app" do
    visit pets_path
    click_on "Start an Application"

    fill_in 'application[name]', with: "James"
    fill_in 'application[street]', with: "1800 nonyabiz"
    fill_in 'application[city]', with: "LHC"
    fill_in 'application[state]', with: "AZ"
    fill_in 'application[zip_code]', with: 86403
    fill_in 'application[description]', with: 'described'
    click_on "Submit"

    expect(page).to have_content("James")
  end

  it "can test flash notice" do
    visit pets_path
    click_on "Start an Application"


    fill_in 'application[name]', with: "James"
    fill_in 'application[street]', with: "1800 nonyabiz"
    fill_in 'application[city]', with: "LHC"
    click_on "Submit"

    expect(page).to have_content("[\"Description can't be blank\", \"State can't be blank\", \"Zip code is not a number\", \"Zip code can't be blank\"]")
  end
end
