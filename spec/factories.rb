FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    sequence(:description) { |n| "This is Group #{n}'s description" }
  end

  factory :role do
    sequence(:name) { |n| "Role #{n}" }
    sequence(:description) { |n| "This is Role #{n}'s description" }
  end

  factory :membership do
    user
    role
    group
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@somedummymail.net" }
    sequence(:name) { |n| "User #{n}" }
    password 'secret'
    password_confirmation 'secret'
    active true
    after_create do |u|
      FactoryGirl.create(:membership, user: u)
    end
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

