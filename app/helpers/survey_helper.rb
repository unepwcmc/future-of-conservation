module SurveyHelper
  def question_pages_count(questions_per_page)
    (Question.count / questions_per_page.to_f).ceil
  end
end
