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

  factory :version, aliases: [:authored_version, :unchecked_version] do
    sequence(:number)
    author 'Author'
    authored_date '2010-01-01'
    document

    factory :checked_version, aliases: [:unapproved_version] do
      checker 'Checker'
      checked_date '2010-01-02'

      factory :approved_version do
        checker 'Approver'
        checked_date '2010-01-03'
      end
    end
  end
end

