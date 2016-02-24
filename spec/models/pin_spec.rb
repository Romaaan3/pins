require 'rails_helper'

describe Pin do
  it "is valid with a title and description" do
    expect(build(:pin)).to be_valid
  end

  it "is invalid without title" do
    pin = build(:pin, title: nil)
    pin.valid?
    expect(pin.errors[:title]).to include("can't be blank")
  end

  it "is invalid without description" do
    pin = build(:pin, description: nil)
    pin.valid?
    expect(pin.errors[:description]).to include("can't be blank")
  end
end
