FactoryGirl.define do
  factory :pin do
    title "My Title"
    description "Description"

    factory :invalid_pin do
      title nil
    end
  end
end
