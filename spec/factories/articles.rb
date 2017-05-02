FactoryGirl.define do 
  factory :article do 
    user
    category
    # association :author, factory: :user 
    #  NoMethodError: undefined method `author=' for #<Article:0x000000073b6ff8>
    name "my blog"
    content {"this is my blog #{Time.now}"}

    trait :publish do 
      publish_state 1
    end

    trait :unpublish do 
      publish_state 0
    end

    factory :publish_article, traits: [:publish]
    factory :unpublish_article, traits: [:unpublish]
  end
end