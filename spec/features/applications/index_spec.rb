require 'rails_helper'

RSpec.describe 'index page' do
  it "can show apps" do
    @app = Application.create!(name: "James Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
    @app2 = Application.create!(name: "John Fox", street: "2286 Huntington Dr", city: "LHC", state: "AZ", zip_code: 86403, description: "I WANT HIM!")
    @app.update!({application_status: "Pending"})
    @app2.update!({application_status: "Pending"})
    visit admin_applications_path
    expect(page).to have_content("#{@app.name}")
    expect(page).to have_content("#{@app2.name}")
  end
end
