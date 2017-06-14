FactoryGirl.define do
  factory :question do
    title 'Valid question title'
    body 'Valid question body'
    user

    factory :invalid_question do
      title nil
      body nil
      user_id nil
    end

    factory :user_question do
      title 'User question title'
      body 'User question body'
    end
  end
end
