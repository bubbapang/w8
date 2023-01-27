require "rails_helper"

RSpec.describe "users/index" do
  let(:jasmine) { User.create!(email: 'jas@jasmine.com', password: 'abcdef') }
  let(:jack) { User.create!(email: 'jack@bruce.com', password: 'abcdef') }

  it "has a header message of \"All Users\"" do
    assign(:users, [jasmine, jack])

    render

    expect(rendered).to match /All Users/
  end

  it "displays all the users" do
    assign(:users, [jasmine, jack])

    render

    expect(rendered).to match /jas@jasmine.com/
    expect(rendered).to match /jack@bruce.com/
  end

  it "displays each user's email as a link to that user's show page" do
    assign(:users, [jasmine, jack])

    render

    expect(rendered).to have_link 'jas@jasmine.com', href: user_url(jasmine)
    expect(rendered).to have_link 'jack@bruce.com', href: user_url(jack)
  end
end
