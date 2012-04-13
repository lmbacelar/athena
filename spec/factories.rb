FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:acronym) { |n| "C#{n}" }
    level 1
  end

  factory :document do
    sequence(:name) { |n| "Doc#{n}" }
    sequence(:title) { |n| "Title #{n}" }
    subtitle 'Subtitle'
    description "This is the document's description"
    category
  end

  factory :version do
    document
  end

  factory :state_change do
    user 'User'
    state 'initiated'
    version
  end
end

