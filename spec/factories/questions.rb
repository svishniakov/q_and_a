FactoryGirl.define do
  factory :question do
    sequence(:title) { |n| "Question #{n} title"}
    body 'Valid question body'
    user

    factory :invalid_question do
      title nil
      body nil
      user nil
    end

    factory :user_question do
      title 'User question title'
      body 'User question body'
    end

    factory :question_with_answers do
      transient do
        answers_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question, user: question.user, best: false)
        create(:answer, question: question, user: question.user, best: true)
      end
    end
  end
end
