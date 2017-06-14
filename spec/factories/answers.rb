FactoryGirl.define do
  factory :answer do
    body 'Valid answer body'
    question
    user

    factory :invalid_answer do
      body nil
      question_id nil
      user_id nil
    end

    factory :user_answer do
      body 'User answer body'
    end
  end
end