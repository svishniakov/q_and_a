FactoryGirl.define do
  factory :question do
    title 'Valid question title'
    body 'Valid question body'
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user_id nil
  end

  factory :user_question, class: 'Question' do
    title 'User question title'
    body 'User question body'
    user
  end
end
