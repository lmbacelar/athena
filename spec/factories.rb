FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@somedummymail.net" }
    sequence(:name) { |n| "User #{n}" }
    password 'secret'
    password_confirmation 'secret'
    active true
  end

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
    user
    state 'initiated'
    version
  end
end

