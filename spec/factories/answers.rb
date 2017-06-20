FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "Answer #{n} body"}
    question
    user

    factory :invalid_answer do
      body nil
      question_id nil
      user nil
    end

    factory :user_answer do
      body 'User answer body'
    end
  end
end