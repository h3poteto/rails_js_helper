require 'spec_helper'

RSpec.feature "RailsHelper", js: true do
  scenario "is compiled properly" do
    visit "/users"

    expect(page.evaluate_script "RailsHelper.pathFor('users')")
      .to eq "/users"

    expect(page.evaluate_script "RailsHelper.pathFor('users', {'format': 'json'})")
      .to eq "/users.json"

    expect(page.evaluate_script "RailsHelper.urlFor('users', {'format': 'json'})")
      .to match(%r(http://#{Regexp.escape(Capybara.server_host)}:\d+/users.json))

    expect(page.evaluate_script "RailsHelper.routeNames()")
      .to match_array ["users", "new_user"]

    expect(page.evaluate_script "RailsHelper.assetPath('scaffold.css')")
      .to eq "/assets/scaffold.css"

    expect(page.evaluate_script "RailsHelper.imagePath('dummy.png')")
      .to eq "/assets/dummy.png"

    expect(page.evaluate_script "RailsHelper.imageTag('dummy.png', {'width': '120'})")
      .to eq "<img src=\"/assets/dummy.png\" width=\"120\">"
  end
end
