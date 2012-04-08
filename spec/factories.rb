FactoryGirl.define do
  factory :document do
    sequence(:name) { |n| "Doc#{n}" }
    title 'Title'
    subtitle 'Subtitle'
    description "This is the document's description"
  end

  factory :version do
    sequence(:number)
    author 'Author'
    authored_date '2010-01-01'
  end
end

