FactoryGirl.define do
  factory :question do
    title 'Valid question title'
    body 'Valid question body'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
