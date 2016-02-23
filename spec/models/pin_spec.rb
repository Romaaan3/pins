require 'rails_helper'

describe Pin do
  it "is valid with a title and description" do
    pin = Pin.new(
      title: 'my pin',
      description: 'nice pin')
    expect(pin).to be_valid
  end

  it "is invalid without title" do
    pin = Pin.new(title: nil)
    pin.valid?
    expect(pin.errors[:title]).to include("can't be blank")
  end

  it "is invalid without description" do
    pin = Pin.new(description: nil)
    pin.valid?
    expect(pin.errors[:description]).to include("can't be blank")
  end
end
