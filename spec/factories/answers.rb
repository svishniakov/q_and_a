FactoryGirl.define do
  factory :answer do
    body 'Valid answer body'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question_id nil
    user_id nil
  end

  factory :user_answer, class: 'Answer' do
    body 'User answer body'
    question
    user
  end
end
