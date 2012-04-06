FactoryGirl.define do
  factory :document do
    sequence(:name) { |n| "Doc#{n}" }
    title "Title"
    subtitle "Subtitle"
    description "This is the document's description"
  end
end

