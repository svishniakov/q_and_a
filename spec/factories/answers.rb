FactoryGirl.define do
  factory :answer do
    body 'Valid answer body'
    question
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question_id nil
  end
end
