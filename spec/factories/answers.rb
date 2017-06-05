FactoryGirl.define do
  factory :answer do
    body 'Valid answer body'
    association :question
  end

  factory :invalid_answer do
    body nil
    question_id nil
  end
end
